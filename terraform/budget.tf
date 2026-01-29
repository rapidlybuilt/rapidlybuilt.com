locals {
  budget_subscriber_email_addresses = "admin@${local.domain_name}"
}

resource "aws_budgets_budget" "baking_rack" {
  name              = module.baking_rack.bucket_name
  budget_type       = "COST"
  limit_amount      = "2"
  limit_unit        = "USD"
  time_unit         = "MONTHLY"

  cost_filter {
    name = "TagKeyValue"
    values = [
      "ApplicationId${"$"}${module.baking_rack.bucket_name}"
    ]
  }

  notification {
    comparison_operator        = "GREATER_THAN"
    threshold                  = 100
    threshold_type             = "PERCENTAGE"
    notification_type          = "FORECASTED"
    subscriber_email_addresses = [local.budget_subscriber_email_addresses]
  }
}

resource "aws_budgets_budget" "motor_mail" {
  name              = module.motor_mail.mail_bucket
  budget_type       = "COST"
  limit_amount      = "10"
  limit_unit        = "USD"
  time_unit         = "MONTHLY"

  cost_filter {
    name = "TagKeyValue"
    values = [
      "ApplicationId${"$"}${module.motor_mail.mail_bucket}"
    ]
  }

  notification {
    comparison_operator        = "GREATER_THAN"
    threshold                  = 100
    threshold_type             = "PERCENTAGE"
    notification_type          = "FORECASTED"
    subscriber_email_addresses = [local.budget_subscriber_email_addresses]
  }
}

resource "aws_budgets_budget" "main" {
  name              = "${module.label.namespace}-${module.label.stage}"
  budget_type       = "COST"
  limit_amount      = "25"
  limit_unit        = "USD"
  time_unit         = "MONTHLY"

  cost_filter {
    name = "TagKeyValue"
    values = [
      "Namespace${"$"}${module.label.namespace}",
      "Stage${"$"}${module.label.stage}"
    ]
  }

  notification {
    comparison_operator        = "GREATER_THAN"
    threshold                  = 100
    threshold_type             = "PERCENTAGE"
    notification_type          = "FORECASTED"
    subscriber_email_addresses = [local.budget_subscriber_email_addresses]
  }
}
