module "baking_rack" {
  source = "git@github.com:dcunning/baking_rack.git//terraform/aws?ref=v0.1.24"

  bucket_name       = "${module.label.id}-www"
  domain_name       = local.domain_name
  branch_name       = local.branch_name
  github_repository = local.github_repository

  # it's only created in staging
  skip_github_openid_provider = terraform.workspace == "production"

  tags = module.label.tags
}

output "baking_rack_iam_role_arn" {
  value = module.baking_rack.iam_role_arn
}

output "baking_rack_bucket_name" {
  value = module.baking_rack.bucket_name
}
