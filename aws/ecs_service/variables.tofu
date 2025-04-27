variable "cluster_arn" {
  description = "ARN of the ECS cluster to deploy into"
  type        = string
}

variable "container_image" {
  description = "Full container image URL"
  type        = string
}

variable "container_port" {
  description = "Container port the application listens on"
  type        = number
}

variable "cpu" {
  description = "Number of CPU units used by the task (e.g. 256, 512)"
  type        = number
  default     = 256
}

variable "desired_count" {
  description = "Number of desired running tasks"
  type        = number
  default     = 1
}

variable "environment" {
  description = "Environment name; must be one of the permitted environment names"
  type        = string
  default     = "production"
}

variable "environment_variables" {
  description = "List of environment variables to pass into the container"
  type = list(object({
    name  = string
    value = string
  }))
  default = []
}


variable "memory" {
  description = "Amount of memory (in MiB) used by the task (e.g. 512, 1024)"
  type        = number
  default     = 1024
}

variable "project_id" {
  description = "Project ID"
  type        = string
}

variable "project_name" {
  description = "Name of the project or service (used in naming ECS resources)"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "eu-west-2"
}


variable "network_mode" {
  default     = "awsvpc"
  description = "Docker networking mode to use for the containers in the task. Valid values are none, bridge, awsvpc, and host."
  type        = string
}

variable "security_group_ids" {
  description = "List of security group IDs for ECS networking"
  type        = list(string)
}

variable "subnet_ids" {
  description = "List of subnet IDs for ECS networking"
  type        = list(string)
}

variable "launch_type" {
  default     = "FARGATE"
  type        = string
  description = "Launch type on which to run your service. The valid values are EC2, FARGATE, and EXTERNAL."
}

variable "dynamodb_table_arn" {
  type        = string
  description = "ARN of the DynamoDB table the app will access"
}

variable "log_retention_in_days" {
  type        = number
  description = "Number of days to keep logs"
  default     = 3
}