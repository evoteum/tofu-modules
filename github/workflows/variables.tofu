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

variable "reusable_workflows_repository" {
  type        = string
  description = "The name of the repository where reusable workflows are stored"
}

variable "workflow_definitions" {
  type        = string
  description = "The name of the file that defines workflow conditions"
  default     = "workflows.yml"
}

variable "organisation" {
  type        = string
  description = "The name of the organisation"
  default     = "evoteum"
}
