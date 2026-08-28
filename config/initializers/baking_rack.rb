BakingRack.config do |c|
  c.build_directory = "tmp/_site"
  c.builder = BakingRack::Rails::Builder.new
  c.deployer = BakingRack::AwsS3::Deployer.new(bucket_name: "rapidlybuilt-production-www")

  c.terraform_directory = "../terraform"

  c.define_static_routes do
    # Redirects
    # Redirect.find_each do |redirect|
    #   get redirect.from_path, status: redirect.status
    # end

    UiDocs::Theme.all.each do |theme|
      get "/gems/rapid-ui/themes/#{theme.path}"
    end

    get "/search/index", content_type: "application/json"

    # HACK: need to explicitly specify this because of how we specify the redirect in RapidUI
    get "/gems/rapid-ui/components/controls/datatables/adapters", status: 301
    get "/gems/rapid-ui/components/controls/datatables/extensions", status: 301
    get "/gems/rapid-ui/components/controls/datatables/features", status: 301

    get_other_rails_routes
  end
end

# HACK: Ruby 3.4 enables CRL checking by default, which fails with AWS certs
ssl_cert_store = OpenSSL::X509::Store.new
ssl_cert_store.set_default_paths
ssl_cert_store.flags = 0  # Disable CRL checking

Aws.config.update(
  ssl_ca_store: ssl_cert_store
)
