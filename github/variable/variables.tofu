variable "sensitive" {
  description = "The variable is sensitive"
  type        = bool
  default     = false
}

variable "scope" {
  description = "Defines where the variable or secret should be stored. Must be a repository name or 'organisation' for org-wide variables."
  type        = string

  validation {
    condition     = can(regex("^organisation$|^[a-zA-Z0-9_.-]+$", var.scope))
    error_message = "Scope must be either 'organisation' or a valid repository name."
  }
}

variable "name" {
  description = "The name of the variable. Will be capitalised."
  type        = string
}

variable "value" {
  description = "The value of the variable"
  type        = string
  sensitive   = true
}
