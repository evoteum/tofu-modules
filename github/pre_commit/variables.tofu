variable "repository_name" {
  description = "Name of the GitHub repository where the file will be created"
  type        = string
}

variable "language" {
  description = "Primary language for the project (e.g., python, go)."
  type        = string
  default     = null
}

variable "needs_tofu" {
  description = "Whether to include tofu hooks (OpenTofu)."
  type        = bool
  default     = false
}

variable "branch" {
  description = "Branch to create the file in."
  type        = string
  default     = "main"
}

variable "cluster_arn" {
  description = "ARN of the ecs cluster"
}