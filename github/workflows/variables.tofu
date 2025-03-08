variable "controller_repo_name" {
  type        = string
  description = "The name of the controller repository"
}

variable "repository" {
  type        = string
  description = "Name of the repository to configure workflows for"
}

variable "repository_configuration" {
  type        = map(any)
  description = "Configuration map for the target repository"
}
