locals {
  cloudfront_caching_disabled_policy_id   = "4135ea2d-6df8-44a3-9df3-4b5a84be39ad"
  cloudfront_forward_everything_policy_id = "b689b0a8-53d0-40ab-baf2-68738e2966ac"
}

resource "aws_cloudfront_distribution" "main" {
  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"

  aliases = [local.domain_name]

  custom_error_response {
    error_caching_min_ttl = 0
    error_code            = 403
    response_code         = 403
    response_page_path    = "/403/index.html"
  }

  custom_error_response {
    error_caching_min_ttl = 0
    error_code            = 404
    response_code         = 404
    response_page_path    = "/404/index.html"
  }

  custom_error_response {
    error_caching_min_ttl = 0
    error_code            = 500
    response_code         = 500
    response_page_path    = "/500/index.html"
  }

  origin {
    domain_name = module.baking_rack.website_endpoint
    origin_id   = "S3-${module.baking_rack.bucket_name}"

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1", "TLSv1.1", "TLSv1.2"]
    }

    custom_header {
      name  = "User-Agent"
      value = module.baking_rack.handshake
    }
  }

  origin {
    domain_name = module.motor_mail.api_gateway_execution_domain_name
    origin_id   = "motor_mail"
    origin_path = "/${module.label.stage}"

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "https-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }

    custom_header {
      name  = "X-Forwarded-Host"
      value = local.domain_name
    }
  }

  origin {
    domain_name = module.motor_mail.assets_endpoint
    origin_id   = "motor_mail_assets"

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1", "TLSv1.1", "TLSv1.2"]
    }
  }

  ordered_cache_behavior {
    path_pattern = "/mail/assets/*"

    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "motor_mail_assets"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 0
    max_ttl                = 0
    compress               = true
  }

  ordered_cache_behavior {
    path_pattern = "/mail/*"

    allowed_methods  = ["HEAD", "DELETE", "POST", "GET", "OPTIONS", "PUT", "PATCH"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "motor_mail"

    cache_policy_id          = local.cloudfront_caching_disabled_policy_id
    origin_request_policy_id = local.cloudfront_forward_everything_policy_id

    viewer_protocol_policy = "redirect-to-https"
    compress               = true
  }

  ordered_cache_behavior {
    path_pattern = "/mail"

    allowed_methods  = ["HEAD", "DELETE", "POST", "GET", "OPTIONS", "PUT", "PATCH"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "motor_mail"

    cache_policy_id          = local.cloudfront_caching_disabled_policy_id
    origin_request_policy_id = local.cloudfront_forward_everything_policy_id

    viewer_protocol_policy = "redirect-to-https"
    compress               = true
  }

  ordered_cache_behavior {
    path_pattern = "/assets/*"
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "S3-${module.baking_rack.bucket_name}"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 0
    max_ttl                = 0
    compress               = true
  }

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "S3-${module.baking_rack.bucket_name}"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    function_association {
      event_type   = "viewer-request"
      # TODO: combine basicauth with path cleanup
      function_arn = terraform.workspace == "staging" ? aws_cloudfront_function.basicauth.arn : aws_cloudfront_function.rails_paths.arn
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 0
    max_ttl                = 0
    compress               = true
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn      = module.ssl_certificate.arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.1_2016"
  }

  tags = module.label.tags
}

module "ssl_certificate" {
  source                            = "cloudposse/acm-request-certificate/aws"
  version                           = "0.18.0"
  domain_name                       = local.domain_name
  process_domain_validation_options = true
  ttl                               = "300"
  zone_id                           = local.zone_id
  environment                       = "us-east-1" # required for CloudFront

  tags = module.label.tags
}

resource "aws_route53_record" "main-a" {
  zone_id = local.zone_id
  name    = local.domain_name
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.main.domain_name
    zone_id                = aws_cloudfront_distribution.main.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_cloudfront_function" "basicauth" {
  name    = "${module.label.id}-basicauth"
  runtime = "cloudfront-js-2.0"
  comment = "Basic Authentication for CloudFront behaviors"
  publish = true
  code    = templatefile("./basicauth.js", {
    username = var.basicauth_username
    password = var.basicauth_password
  })
}

# TODO: extract this to baking_rack if it works
resource "aws_cloudfront_function" "rails_paths" {
  name    = "${module.label.id}-rails-paths"
  runtime = "cloudfront-js-2.0"
  comment = "Polish paths for Baking Rack + Rails"
  publish = true
  code    = file("./rails_paths.js")
}
