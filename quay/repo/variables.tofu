variable "name" {
  description = "Name of the Quay repository to create"
  type        = string
}

variable "organization" {
  description = "Quay organization where the repository will be created"
  type        = string
}

variable "visibility" {
  description = "Repository visibility (public or private)"
  type        = string
  default     = "public"
  validation {
    condition     = contains(["public", "private"], var.visibility)
    error_message = "Visibility must be either 'public' or 'private'"
  }
}

variable "description" {
  description = "Description of the repository"
  type        = string
  default     = ""
} 