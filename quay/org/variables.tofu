variable "organization_name" {
  description = "Name of the Quay organization to create"
  type        = string
}

variable "email" {
  description = "Email address for the organization"
  type        = string
}

variable "visibility" {
  description = "Organization visibility (public or private)"
  type        = string
  default     = "public"
  validation {
    condition     = contains(["public", "private"], var.visibility)
    error_message = "Visibility must be either 'public' or 'private'"
  }
}

variable "description" {
  description = "Description of the organization"
  type        = string
  default     = ""
}
