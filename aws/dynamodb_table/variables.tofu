variable "project_name" {
  description = "Project name to be used for resource naming"
  type        = string
}

variable "table_name" {
  description = "Name of the DynamoDB table"
  type        = string
  sensitive   = false
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

variable "global_secondary_index_name" {
  description = "Name of the global secondary index"
  type        = string
  sensitive   = false
}

variable "global_secondary_index_hash_key" {
  description = "Hash key of the global secondary index"
  type        = string
  sensitive   = false
}