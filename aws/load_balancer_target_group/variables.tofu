variable "environment" {
  description = "The deployment environment name (e.g. 'production', 'staging', 'development')"
  type        = string
}

variable "health_check_healthy_threshold" {
  description = "Number of successes to mark target healthy"
  type        = number
  default     = 2
}

variable "health_check_interval" {
  description = "Interval between health checks (in seconds)"
  type        = number
  default     = 30
}

variable "health_check_matcher" {
  description = "HTTP codes considered healthy"
  type        = string
  default     = "200-399"
}

variable "health_check_path" {
  description = "Path to check for container health"
  type        = string
  default     = "/health"
}

variable "health_check_timeout" {
  description = "Timeout for each health check"
  type        = number
  default     = 5
}

variable "health_check_unhealthy_threshold" {
  description = "Number of failures to mark target unhealthy"
  type        = number
  default     = 2
}

variable "port" {
  description = "The port on which the targets receive traffic"
  type        = number
  default     = 80
}

variable "project" {
  description = "An identifier used to namespace resources across environments or services (often a short unique slug)"
  type        = string
}

variable "protocol" {
  description = "The protocol used for routing traffic to the targets. Valid values are 'HTTP' or 'HTTPS'"
  type        = string
  default     = "HTTP"
}

variable "target_type" {
  description = "The type of target that the load balancer will route traffic to. Valid values are 'instance', 'ip', or 'lambda'"
  type        = string
  default     = "ip"
}

variable "vpc_id" {
  description = "The ID of the VPC in which the target group will be created"
  type        = string
}
