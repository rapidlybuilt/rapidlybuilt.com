require "test_helper"
require_relative "../../lib/origin_secret_middleware"

class OriginSecretMiddlewareTest < ActiveSupport::TestCase
  def dummy_app
    ->(env) { [200, { "Content-Type" => "text/html" }, ["OK"]] }
  end

  def rack_env(path = "/", headers = {})
    env = Rack::MockRequest.env_for("http://example.com#{path}")
    headers.each { |name, value| env["HTTP_#{name.upcase.gsub(?-, ?_)}"] = value }
    env
  end

  def stub_credentials(origin_secret)
    app = Rails.application
    creds = Object.new
    creds.define_singleton_method(:origin_secret) { origin_secret }
    original = app.method(:credentials)
    app.define_singleton_method(:credentials) { creds }
    yield
  ensure
    app.define_singleton_method(:credentials, original)
  end

  def stub_host_authorization(value)
    config = Rails.application.config
    original = config.method(:host_authorization)
    config.define_singleton_method(:host_authorization) { value }
    yield
  ensure
    config.define_singleton_method(:host_authorization, original)
  end

  test "returns 200 when X-Origin-Secret matches credentials" do
    stub_credentials("secret123") do
      middleware = OriginSecretMiddleware.new(dummy_app)
      status, _headers, body = middleware.call(rack_env("/", "X-Origin-Secret" => "secret123"))
      assert_equal 200, status
      assert_equal ["OK"], body
    end
  end

  test "returns 403 when X-Origin-Secret is missing" do
    stub_credentials("secret123") do
      middleware = OriginSecretMiddleware.new(dummy_app)
      status, headers, body = middleware.call(rack_env("/"))
      assert_equal 403, status
      assert_equal "text/plain", headers["Content-Type"]
      assert_equal ["Forbidden: Invalid origin secret"], body
    end
  end

  test "returns 403 when X-Origin-Secret does not match" do
    stub_credentials("secret123") do
      middleware = OriginSecretMiddleware.new(dummy_app)
      status, _headers, body = middleware.call(rack_env("/", "X-Origin-Secret" => "wrong"))
      assert_equal 403, status
      assert_equal ["Forbidden: Invalid origin secret"], body
    end
  end

  test "passes through when host_authorization exclude proc returns true for request" do
    stub_credentials("secret123") do
      stub_host_authorization({ exclude: ->(req) { req.path == "/up" } }) do
        middleware = OriginSecretMiddleware.new(dummy_app)
        # /up without secret should pass (excluded)
        status, _headers, body = middleware.call(rack_env("/up"))
        assert_equal 200, status, "excluded path /up should pass without secret"
        assert_equal ["OK"], body

        # /other with wrong secret should still be forbidden
        status, _headers, body = middleware.call(rack_env("/other", "X-Origin-Secret" => "wrong"))
        assert_equal 403, status
      end
    end
  end

  test "does not use exclude when host_authorization is not a Hash with :exclude" do
    stub_credentials("secret123") do
      stub_host_authorization(true) do
        middleware = OriginSecretMiddleware.new(dummy_app)
        # host_authorization true (default) or without exclude -> /up still requires secret
        status, _headers, _body = middleware.call(rack_env("/up"))
        assert_equal 403, status
      end
    end
  end
end
