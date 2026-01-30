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
      get "/tools/rapid-ui/themes/#{theme.path}"
    end

    get "/api/search.json"

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
