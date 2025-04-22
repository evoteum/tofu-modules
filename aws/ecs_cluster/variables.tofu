variable "environment" {
  description = "Environment name; must be one of the permitted environment names"
  type        = string
  default     = "production"
}

variable "name" {
  description = "The name of the ECS cluster"
  type        = string
  default     = "estate"
}

variable "enable_container_insights" {
  description = "Enable CloudWatch Container Insights"
  type        = bool
  default     = false
}

variable "project_name" {
  description = "Project name"
  type        = string
}
