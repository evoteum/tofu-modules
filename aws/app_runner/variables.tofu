variable "project_name" {
  description = "Project name"
  type        = string
}

variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "container_image" {
  description = "Continer image URL"
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

variable "port" {
  description = "Port the container listens on"
  type        = number
  default     = 8080
}

variable "enable_ecr" {
  description = "Enable ECR access for App Runner"
  type        = bool
  default     = false
}

variable "environment" {
  description = "Environment name; must be one of: ${join(", ", module.common.environment_names)}"
  type        = string
  default     = "prod"
  
  validation {
    condition     = contains(module.common.environment_names, var.environment)
    error_message = "Environment must be one of: ${join(", ", module.common.environment_names)}"
  }
}
