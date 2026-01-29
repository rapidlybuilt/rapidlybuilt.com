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
