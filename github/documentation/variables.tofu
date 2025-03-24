variable "artefact_type" {
  description = "Type of artefact this repo produces (e.g., container)"
  type        = string
  default     = ""
}

variable "management_repo_name" {
  description = "The name of the repo that manages the target repo"
  type        = string
}

variable "management_repo_url" {
  description = "The HTML URL of the repo that manages the target repo"
  type        = string
}

variable "quay_domain" {
  description = "The base domain of the Quay server"
  type        = string
  default     = "quay.io"
}

variable "quay_repository_url" {
  description = "The HTML url of the quay repo"
  type        = string
  default     = ""
}

variable "repository_name" {
  type = string
}

variable "repository_owner" {
  type = string
}
