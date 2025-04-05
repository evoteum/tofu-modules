variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "eu-west-2"
}

variable "container_image" {
  description = "Container image URL"
  type        = string
}

variable "cpu" {
  description = "CPU units for the service (1024 = 1 vCPU)"
  type        = number
  default     = 1024
}

variable "custom_domain" {
  description = "Custom domain endpoint to associate"
  type        = string
  default     = ""
}

variable "database_arns" {
  description = "List of database ARNs this App Runner service needs access to"
  type        = list(string)
  default     = []
}

variable "enable_ecr" {
  description = "Enable ECR access for App Runner"
  type        = bool
  default     = false
}

variable "environment" {
  description = "Environment name; must be one of the permitted environment names"
  type        = string
  default     = "production"
}

variable "health_check_healthy_threshold" {
  description = "Number of consecutive health check successes required"
  type        = number
  default     = 3
}

variable "health_check_interval" {
  description = "Health check interval"
  type        = number
  default     = 30
}

variable "health_check_path" {
  description = "Health check path for the service"
  type        = string
  default     = "/health"
}

variable "health_check_timeout" {
  description = "Health check timeout in seconds"
  type        = number
  default     = 5
}

variable "health_check_unhealthy_threshold" {
  description = "Number of consecutive health check failures required"
  type        = number
  default     = 3
}

variable "max_concurrency" {
  description = "Maximum number of concurrent requests per instance"
  type        = number
  default     = 100
}

variable "max_instances" {
  description = "Maximum number of instances"
  type        = number
  default     = 10
}

variable "memory" {
  description = "Memory in MB for the service"
  type        = number
  default     = 2048
}

variable "min_instances" {
  description = "Minimum number of instances"
  type        = number
  default     = 0
}

variable "port" {
  description = "Port the container listens on"
  type        = number
  default     = 8080
}

variable "project_name" {
  description = "Project name"
  type        = string
}

variable "runtime_environment_variables" {
  description = "Environment variables for the App Runner service"
  type        = map(string)
  default     = {}
}

variable "service_arns" {
  description = "Map of service ARNs this App Runner service needs access to"
  type = object({
    databases = optional(list(string), []) # DynamoDB, RDS, ElastiCache
    storage   = optional(list(string), []) # S3 buckets
    secrets   = optional(list(string), []) # Secrets Manager, SSM Parameter Store
    messaging = optional(list(string), []) # SQS queues, SNS topics
    kms       = optional(list(string), []) # KMS keys
  })
  default = {}
}

variable "vpc_connector_arn" {
  description = "VPC connector ARN"
  type        = string
  default     = null
}
