module "motor_mail" {
  source = "git@github.com:dcunning/motor_mail.git//terraform/aws?ref=v0.2.20"
  # source = "../../motor_mail/terraform/aws"

  id    = "${module.label.id}-mail"
  stage = module.label.stage
  tags  = module.label.tags

  aws_region  = local.aws_region
  zone_id     = local.zone_id
  domain_name = local.domain_name

  working_dir = "./mail"
}
