variable "alb_dns_name" {
  description = "Address of the load balancer to assign this to"
  type        = string
}

variable "alb_security_group_id" {
  description = "The security group ID of the ALB that will send traffic to this ECS service"
  type        = string
}

variable "cloudflare_account_id" {
  description = "ID of the cloudflare account"
  type        = string
}

variable "cluster_arn" {
  description = "ARN of the ECS cluster to deploy into"
  type        = string
}

variable "container_port" {
  description = "Container port the application listens on"
  type        = number
  default     = 8080
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

variable "dynamodb" {
  description = "All inputs for configuring the DynamoDB table"
  type = object({
    table_name   = optional(string, "table")
    billing_mode = optional(string, "PAY_PER_REQUEST")
    hash_key     = string
    range_key    = optional(string)
    attributes   = map(string)
    global_secondary_indexes = optional(map(object({
      hash_key        = string
      range_key       = optional(string)
      projection_type = string
    })), {})
  })
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
  description = "Path to the health check"
  type        = string
  default     = "/health"
}

variable "homepage_url" {
  description = "The web address of the project"
  type        = string
}

variable "launch_type" {
  default     = "FARGATE"
  type        = string
  description = "Launch type on which to run your service. The valid values are EC2, FARGATE, and EXTERNAL."
}

variable "listener_arn" {
  description = "ARN of the listener to add the rule to"
  type        = string
}

variable "log_retention_in_days" {
  type        = number
  description = "Number of days to keep logs"
  default     = 3
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

variable "organisation" {
  description = "The name of the organisation"
  type        = string
}

variable "priority" {
  description = "Manual priority of the listener rule (must be unique per listener). If not set, a priority will be automatically assigned."
  type        = number
  default     = null
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "eu-west-2"
}

variable "repository_archived" {
  description = "Whether the repository is archived"
  type        = bool
}

variable "repository_description" {
  description = "The description of this git repository"
  type        = string
}

variable "repository_id" {
  description = "The GitHub API ID for this repository"
  type        = string
}

variable "repository_name" {
  default = "The name of this repository"
  type    = string
}

variable "repository_url" {
  description = "HTML URL of this git repository"
  type        = string
  default     = ""
}

variable "repository_visibility" {
  description = "Whether this repository is public or private"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC that this service will be installed in"
  type        = string
}
