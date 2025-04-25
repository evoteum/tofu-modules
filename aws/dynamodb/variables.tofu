variable "attributes" {
  description = "A map of attribute names to their types. Valid types: S, N, B."
  type        = map(string)
  default     = {}
  validation {
    condition = alltrue([
      for t in values(var.attributes) : contains(["s", "n", "b", "S", "N", "B"], t)
    ])
    error_message = "All attribute types must be one of: S, N, or B."
  }
}

variable "billing_mode" {
  default     = "PAY_PER_REQUEST"
  type        = string
  description = "Controls how you are charged for read and write throughput and how you manage capacity. The valid values are PROVISIONED and PAY_PER_REQUEST."
}

variable "environment" {
  description = "Environment name; must be one of the permitted environment names"
  type        = string
  default     = "production"
}

variable "global_secondary_indexes" {
  description = "Map of GSI names to their index configuration"
  type = map(object({
    hash_key        = string
    range_key       = string
    projection_type = string
  }))
  default = {}
}

variable "hash_key" {
  type        = string
  description = "Name of the hash key in the index; must be defined as an attribute."
}

variable "project_name" {
  description = "Project name to be used for resource naming"
  type        = string
}

variable "range_key" {
  type        = string
  description = "Attribute to use as the range (sort) key. Must also be defined as an attribute."
}

variable "table_name" {
  description = "Name of the DynamoDB table"
  type        = string
  sensitive   = false
  default     = "table"
}

variable "project_id" {
  description = "ID of the project"
  type = string
}