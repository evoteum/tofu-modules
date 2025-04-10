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

variable "environment" {
  description = "Environment name; must be one of the permitted environment names"
  type        = string
  default     = "production"
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

variable "project_name" {
  description = "Project name"
  type        = string
}
