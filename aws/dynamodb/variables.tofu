variable "environment" {
  description = "Environment name; must be one of the permitted environment names"
  type        = string
  default     = "production"
}

variable "attributes" {
  description = "The name and type of each attribute. type can be S (string), N (number), B (binary)."
  type = list(object({
    name = string
    type = string
  }))
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
