variable "artifact_type" {
  description = "The type of artifact that the project needs to output"
  type        = string
  default     = null
}

variable "language" {
  description = "The language that the source code is written in"
  type        = string
  default     = null
}

variable "language_version" {
  description = "The version of the language that the source code is written in"
  type        = string
  default     = null
}

variable "needs_tofu" {
  description = "Has OpenTofu code at tofu/[environment]"
  type        = bool
  default     = false
}

variable "linters" {
  description = "Which linters should be included?"
  type        = list(string)
  default     = null
}

variable "todo_issue_disabled" {
  description = "TODO to Issue is disabled"
  type        = bool
  default     = false
}

variable "repository" {
  description = "Name of the target GitHub repository"
  type        = string
}

variable "source_path" {
  description = "The repository path to the source code"
  type        = string
  default     = ""
}

variable "reusable_workflows_repository" {
  description = "Name of the repository used to store reusable workflows"
  type        = string
  default     = "estate-reusable-workflows"
}

variable "workflow_definitions" {
  description = "The name of the file in the root of the reusable workflows repository that defines the conditions for the workflows"
  type        = string
  default     = "workflows.yml"
}

variable "controller_repo_name" {
  description = "The name of the repository that controls the target repository"
  type        = string
  default     = "estate-repos"
}
