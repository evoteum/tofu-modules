variable "certificate_arn" {
  description = "ARN of the certificate to associate with this LB"
  type        = string
}

variable "enable_deletion_protection" {
  default     = false
  type        = bool
  description = "Should deletion protection be enabled?"
  nullable    = false
}

variable "enable_http_redirect" {
  default  = true
  nullable = false

  description = "Force everyone to HTTPS"
  type        = bool
}

variable "environment" {
  description = "Environment name; must be one of the permitted environment names"
  type        = string
  default     = "production"
  nullable    = false

}

variable "idle_timeout" {
  default  = 60
  nullable = false

  type = number
}

variable "name" {
  description = "the name of this LB"
  type        = string
  default     = "lb"
  nullable    = false

}

variable "project_id" {
  description = "Project ID"
  type        = string
}

variable "project_name" {
  description = "Project name"
  type        = string
}

variable "subnet_ids" {
  description = "Subnets to use for the load balancer"
  type        = list(string)
}

variable "type" {
  description = "Type of load balancer to create. Possible values are application, gateway, or network."
  default     = "application"
  nullable    = false
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}
