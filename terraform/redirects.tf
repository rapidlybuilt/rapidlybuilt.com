module "production_redirects" {
  source = "git@github.com:dcunning/baking_rack.git//terraform/aws-redirects?ref=v0.1.23"

  count = terraform.workspace == "production" ? 1 : 0

  zone_id     = local.zone_id
  bucket_name = "${module.label.id}-redirects"

  from_domain_name = "www.rapidlybuilt.com"
  to_domain_name   = local.domain_name

  tags = module.label.tags
}
