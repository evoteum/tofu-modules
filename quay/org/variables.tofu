variable "organisation" {
  description = "Name of the Quay organization to create"
  type        = string
}

variable "email" {
  description = "Email address for the organization"
  type        = string
}

variable "prevent_destroy" {
  description = "Prevent the repo from being destroyed"
  type        = bool
  default     = true
}