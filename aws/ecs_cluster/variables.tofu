variable "enable_container_insights" {
  description = "Enable CloudWatch Container Insights"
  type        = bool
  default     = false
  nullable    = false
}

variable "environment" {
  description = "Environment name; must be one of the permitted environment names"
  type        = string
  default     = "production"
  nullable    = false
}

variable "name" {
  description = "The name of the ECS cluster"
  type        = string
  default     = "estate"
  nullable    = false
}

variable "project_id" {
  description = "Project id"
  type        = string
}

variable "project_name" {
  description = "Project name"
  type        = string
}
