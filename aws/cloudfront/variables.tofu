variable "project_name" {
  description = "Project name"
  type        = string
}

variable "environment" {
  description = "Environment name; must be one of: ${join(", ", module.common.environments)}"
  type        = string
  default     = "production"

  validation {
    condition     = contains(module.common.environments, var.environment)
    error_message = "Environment must be one of: ${join(", ", module.common.environments)}"
  }
}

variable "origin_url" {
  description = "Origin URL (e.g., App Runner URL, ECS service URL, ALB URL, etc.)"
  type        = string
}

variable "price_class" {
  description = "CloudFront price class"
  type        = string
  default     = "PriceClass_100"
  validation {
    condition     = contains(["PriceClass_All", "PriceClass_200", "PriceClass_100"], var.price_class)
    error_message = "Price class must be one of: PriceClass_All, PriceClass_200, PriceClass_100"
  }
}

variable "allowed_methods" {
  description = "Allowed HTTP methods"
  type        = list(string)
  default     = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"]
}

variable "cached_methods" {
  description = "HTTP methods to cache"
  type        = list(string)
  default     = ["GET", "HEAD", "OPTIONS"]
}
