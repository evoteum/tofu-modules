variable "application_source_uri" {
  description = "URI of the application source. Must be one of:\n- A GitHub repository URL (must contain \"github.com\")\n- An ECR image URI "
  type        = string
}

variable "auto_deployments_enabled" {
  description = "Whether continuous integration from the source repository is enabled for the App Runner service. If set to true, each repository change (source code commit or new image version) starts a deployment."
  type        = bool
  default     = true
}

variable "aws_apprunner_connection_arn" {
  description = "ARN of the existing AWS AppRunner Connection - ensure you have manually enabled it!"
  type        = string
}

variable "build_command" {
  description = "If using source deployment, the command needed to build the application"
  type        = string
  default     = ""
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
  default     = 20
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

variable "is_publicly_accessible" {
  description = "Should this application be publicly accessible?"
  type        = bool
  default     = true
}

variable "memory" {
  description = "Memory in MB for the service"
  type        = number
  default     = 2048
}

variable "organisation" {
  description = "The name of the organisation"
  type        = string
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

variable "runtime" {
  description = "The language and version to use for the App Runner runtime. Example: { language = \"nodejs\", version = \"16\" }"
  type = object({
    language = string
    version  = string
  })
  default = {
    language = "go"
    version  = "1"
  }
}

variable "runtime_environment_variables" {
  description = "Environment variables for the App Runner service"
  type        = map(string)
  default     = {}
}

variable "runtime_environment_secrets" {
  description = "Environment secrets for the App Runner service"
  type        = map(string)
  default     = {}
}

variable "service_arns" {
  description = "Map of service ARNs this App Runner service needs access to"
  type = object({
    databases = optional(list(string), []) # dynamodb
  })
  default = {}
}

variable "source_branch" {
  description = "If using source deployment, which branch should be deployed?"
  type        = string
  default     = "main"
}

variable "start_command" {
  description = "If using source deployment, the command needed to run the application"
  type        = string
  default     = ""
}

variable "vpc_connector_arn" {
  description = "VPC connector ARN"
  type        = string
  default     = null
}
