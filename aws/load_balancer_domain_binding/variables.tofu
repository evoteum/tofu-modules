variable "certificate_arn" {
  description = "ARN of the certificate to associate with the LB"
  type        = string
}

variable "listener_arn" {
  description = "ARN of the certificate to associate with the LB"
  type        = string
}

variable "target_group_arn" {
  description = "ARN of the target group to forward traffic to"
  type        = string
}

variable "host" {
  description = "Domain name to match for routing (e.g. www.example.com)"
  type        = string
}

variable "priority" {
  description = "Manual priority of the listener rule (must be unique per listener). If not set, a priority will be automatically assigned."
  type        = number
  default     = null
}
