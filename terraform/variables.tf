variable "basicauth_username" {
  type        = string
  sensitive   = true
  description = "Username for basic authentication on staging"
}

variable "basicauth_password" {
  type        = string
  sensitive   = true
  description = "Password for basic authentication on staging"
}

variable "origin_secret" {
  type        = string
  sensitive   = true
  description = "Secret value for X-Origin-Secret header to authenticate requests from CloudFront"
}

variable "ssh_allowed_cidr" {
  type        = list(string)
  sensitive   = true
  description = "CIDR blocks allowed to SSH into the origin EC2 instance (e.g. [\"1.2.3.4/32\", \"5.6.7.8/32\"])"
}
