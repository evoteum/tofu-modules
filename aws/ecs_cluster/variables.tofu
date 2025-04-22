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

variable "vpc_arn" {
  default     = null
  description = "ARN of the vpc where this cluster will live"
  type        = string
}

variable "subnet_ids" {
  description = "Subnets for ALB and ECS tasks"
  type        = list(string)
}


variable "project_name" {
  description = "Project name"
  type        = string
}
