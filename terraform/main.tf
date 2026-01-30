terraform {
  required_version = "~> 1.6"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket = "terraform.rapidlybuilt.com"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = local.aws_region
}

locals {
  workspace_settings = {
    staging = {
      aws_region  = "us-east-1"
      domain_name = "staging.rapidlybuilt.com"
      branch_name = "staging"
    }

    production = {
      aws_region  = "us-east-1"
      domain_name = "rapidlybuilt.com"
      branch_name = "main"
    }
  }

  current_workspace = local.workspace_settings[terraform.workspace]

  aws_region  = local.current_workspace.aws_region
  domain_name = local.current_workspace.domain_name
  branch_name = local.current_workspace.branch_name

  # dynamically lookup the zone ID for the production domain
  zone_id     = data.aws_route53_zone.main.zone_id

  github_repository = "rapidlybuilt/rapidlybuilt.com"
  common_tags       = {}
}

data "aws_route53_zone" "main" {
  name         = "${local.workspace_settings.production.domain_name}."
  private_zone = false
}

module "label" {
  source  = "cloudposse/label/null"
  version = "0.25.0"

  namespace = "rapidlybuilt"
  stage     = terraform.workspace

  tags = merge(
    {
      ManagedBy = "Terraform"
    },
    local.common_tags
  )
}
