variable "project_name" {
  description = "Project name to be used for resource naming"
  type        = string
}

variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "container_image" {
  description = "Docker image URL"
  type        = string
}

variable "runtime_environment_variables" {
  description = "Environment variables for the App Runner service"
  type        = map(string)
  default     = {}
}

variable "cpu" {
  description = "CPU units for the service (1024 = 1 vCPU)"
  type        = number
  default     = 1024
}

variable "memory" {
  description = "Memory in MB for the service"
  type        = number
  default     = 2048
}

variable "health_check_path" {
  description = "Health check path for the service"
  type        = string
  default     = "/health"
}
