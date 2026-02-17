class OriginSecretMiddleware
  def initialize(app)
    @app = app
    @secret = Rails.application.credentials.origin_secret
  end

  def call(env)
    request = ActionDispatch::Request.new(env)

    # Skip origin secret check when host_authorization would exclude this request (e.g. /up)
    host_auth = Rails.application.config.host_authorization
    exclude_proc = host_auth.is_a?(Hash) && host_auth[:exclude]
    return @app.call(env) if exclude_proc && exclude_proc.call(request)

    provided_secret = request.headers["X-Origin-Secret"]

    unless provided_secret == @secret
      return [
        403,
        { "Content-Type" => "text/plain" },
        ["Forbidden: Invalid origin secret"]
      ]
    end

    @app.call(env)
  end
end
