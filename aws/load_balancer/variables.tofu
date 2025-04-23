variable "enable_http_redirect" {
  default     = true
  description = "Force everyone to HTTPS"
  type        = bool
}

variable "certificate_arn" {
  description = "ARN of the certificate to associate with this LB"
  type        = string
}

variable "enable_deletion_protection" {
  default     = true
  type        = bool
  description = "Should deletion protection be enabled?"
}

variable "environment" {
  description = "Environment name; must be one of the permitted environment names"
  type        = string
  default     = "production"
}

variable "subnet_ids" {
  description = "Subnets to use for the load balancer"
  type        = list(string)
}

variable "project_name" {
  description = "Project name"
  type        = string
}

variable "name" {
  description = "the name of this LB"
  type        = string
  default     = "lb"
}

variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "type" {
  description = "Type of load balancer to create. Possible values are application, gateway, or network."
  default = "application"
  type = string
}