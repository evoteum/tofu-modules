variable "environment" {
  description = "Environment name; must be one of the permitted environment names"
  type        = string
  default     = "production"
}

variable "project_name" {
  description = "Project name to be used for resource naming"
  type        = string
}

variable "table_name" {
  description = "Name of the DynamoDB table"
  type        = string
  sensitive   = false
  default = "table"
}
