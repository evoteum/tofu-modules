variable "description" {
  description = "Description of the repository"
  type        = string
  default     = ""
}

variable "name" {
  description = "Name of the Quay repository to create"
  type        = string
}

variable "organisation" {
  description = "Quay organisation where the repository will be created"
  type        = string
}

variable "quay_url" {
  description = "URL of the Quay server"
  type        = string
  default     = "https://quay.io"
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
