# TODO: a more secure (but more expensive) way to create this EC2 instance is to
# place it behind an ALB + CloudFront VPC Origins.
#
# For now, using Security Groups and an Origin-Header to authenticate requests from CloudFront
# will work.

# Data source to get CloudFront IP ranges
data "aws_ec2_managed_prefix_list" "cloudfront_origin_ipv4" {
  name = "com.amazonaws.global.cloudfront.origin-facing"
}

# Security group for the origin EC2 instance
resource "aws_security_group" "app" {
  name        = "${module.label.id}-app"
  description = "Security group for app EC2 instance - allows CloudFront and SSH"
  vpc_id      = data.aws_vpc.default.id

  # Allow inbound HTTP from CloudFront
  # SECURITY WARNING: this isn't ideal; we should use HTTPS from CloudFront instead
  # BUT kamal-proxy can't validate/issue a Let's Encrypt certificate because of this security group
  ingress {
    description     = "HTTP from CloudFront"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    prefix_list_ids = [data.aws_ec2_managed_prefix_list.cloudfront_origin_ipv4.id]
  }

  # Allow SSH from allowed CIDR
  ingress {
    description = "SSH only allowed from developer IP addresses"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.ssh_allowed_cidr
  }

  # Allow all outbound traffic
  egress {
    description = "All outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    module.label.tags,
    {
      Name = "${module.label.id}-app"
    }
  )
}

# SSH key pair for the app instance (used by Kamal to deploy).
# The private key is output after apply; save it and point Kamal at it (see README or output).
resource "tls_private_key" "app" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "app" {
  key_name   = "${module.label.id}-app"
  public_key = tls_private_key.app.public_key_openssh

  tags = merge(
    module.label.tags,
    {
      Name = "${module.label.id}-app"
    }
  )
}

# Elastic IP for the origin instance
resource "aws_eip" "app" {
  domain = "vpc"
  tags = merge(
    module.label.tags,
    {
      Name = "${module.label.id}-app"
    }
  )
}

# EC2 instance for app server
resource "aws_instance" "app" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t4g.micro"
  subnet_id     = data.aws_subnets.default.ids[0]
  key_name      = aws_key_pair.app.key_name

  root_block_device {
    volume_size = 8
    volume_type = "gp3"
  }

  vpc_security_group_ids = [aws_security_group.app.id]

  user_data = <<-EOF
    #!/bin/bash
    yum update -y
    yum install -y docker
    systemctl start docker
    systemctl enable docker
    usermod -a -G docker ec2-user
  EOF

  tags = merge(
    module.label.tags,
    {
      Name = "${module.label.id}-app"
    }
  )
}

# Associate Elastic IP with the instance
resource "aws_eip_association" "app" {
  instance_id   = aws_instance.app.id
  allocation_id = aws_eip.app.id
}

# Data source for default VPC
data "aws_vpc" "default" {
  default = true
}

# Data source for default subnets
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# Data source for Amazon Linux AMI
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-arm64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Route53 record for the Rails app
resource "aws_route53_record" "app" {
  zone_id = local.zone_id
  name    = local.app.domain_name
  type    = "A"

  ttl     = 300
  records = [aws_eip.app.public_ip]
}

# ECR repository for app images
resource "aws_ecr_repository" "app" {
  name                 = module.label.id
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = merge(
    module.label.tags,
    {
      Name = "${module.label.id}-ecr"
    }
  )
}

# Keep only the last 5 images; expire older ones
resource "aws_ecr_lifecycle_policy" "app" {
  repository = aws_ecr_repository.app.name

  policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Keep last 5 images"
        selection = {
          tagStatus   = "any"
          countType   = "imageCountMoreThan"
          countNumber = 5
        }
        action = {
          type = "expire"
        }
      }
    ]
  })
}

locals {
  app = {
    domain_name = "app.${local.domain_name}"
  }
}

output "ecr_server" {
  description = "ECR registry server (host) for docker login and push"
  value       = "${aws_ecr_repository.app.registry_id}.dkr.ecr.${local.aws_region}.amazonaws.com"
}

output "app_private_key" {
  description = "SSH private key for the app instance (ec2-user). Save to ~/.ssh and chmod 600, then use with Kamal."
  value       = tls_private_key.app.private_key_openssh
  sensitive   = true
}
