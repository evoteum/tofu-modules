variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "eu-west-2"
}

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

variable "dynamodb_table_arn" {
  type        = string
  description = "ARN of the DynamoDB table the app will access"
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

variable "health_check_path" {
  type        = string
  description = "path to the health check"
  default     = "/health"
  nullable    = false

}

variable "launch_type" {
  default     = "FARGATE"
  type        = string
  nullable    = false
  description = "Launch type on which to run your service. The valid values are EC2, FARGATE, and EXTERNAL."
}

variable "lb_security_group_id" {
  description = "The security group ID of the load balancer that will send traffic to this ECS service"
  type        = string
}

variable "log_retention_in_days" {
  type        = number
  description = "Number of days to keep logs"
  default     = 3
  nullable    = false
}

variable "memory" {
  description = "Amount of memory (in MiB) used by the task (e.g. 512, 1024)"
  type        = number
  default     = 1024
}

variable "network_mode" {
  default     = "awsvpc"
  description = "Docker networking mode to use for the containers in the task. Valid values are none, bridge, awsvpc, and host."
  type        = string
}

variable "project_id" {
  description = "Project ID"
  type        = string
}

variable "project_name" {
  description = "Name of the project or service (used in naming ECS resources)"
  type        = string
}

variable "service_security_group_ids" {
  description = "Optional additional security group(s) to assign to this ECS service"
  type        = list(string)
  default     = []
}

variable "subnet_ids" {
  description = "List of subnet IDs for ECS networking"
  type        = list(string)
}

variable "vpc_id" {
  description = "ID of the VPC that this service will be installed in"
  type        = string
}
