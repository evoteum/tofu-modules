variable "repo_name" {
  description = "The name of the repository"
  type        = optional(string)
  sensitive   = false
}

variable "repo_description" {
  description = "The description of the repository"
  type        = optional(string)
  sensitive   = false
}

variable "homepage_url" {
  description = "The optional homepage URL for the repository"
  type        = optional(string)
  default     = null
}

variable "visibility" {
  description = "The visibility of the repository (must be 'public' or 'private')"
  type        = optional(string)
  default     = "public"

  validation {
    condition     = contains(["public", "private", null], var.visibility)
    error_message = "Invalid value for visibility. Allowed values are 'public' or 'private'."
  }
}

variable "has_issues" {
  description = "Enable GitHub issues"
  type        = optional(bool)
  default     = true
}

variable "has_discussions" {
  description = "Enable GitHub discussions"
  type        = optional(bool)
  default     = false
}

variable "has_projects" {
  description = "Enable GitHub projects"
  type        = optional(bool)
  default     = false
}

variable "has_wiki" {
  description = "Enable GitHub wiki"
  type        = optional(bool)
  default     = false
}

variable "allow_merge_commit" {
  description = "Allow merge commits"
  type        = optional(bool)
  default     = true
}

variable "allow_squash_merge" {
  description = "Allow squash merging"
  type        = optional(bool)
  default     = true
}

variable "allow_rebase_merge" {
  description = "Allow rebase merging"
  type        = optional(bool)
  default     = false
}

variable "allow_auto_merge" {
  description = "Allow auto-merging of pull requests"
  type        = optional(bool)
  default     = false
}

variable "squash_merge_commit_title" {
  description = "Title format for squash merge commits"
  type        = optional(string)
  default     = "COMMIT_OR_PR_TITLE"
}

variable "squash_merge_commit_message" {
  description = "Message format for squash merge commits"
  type        = optional(string)
  default     = "COMMIT_MESSAGES"
}

variable "merge_commit_title" {
  description = "Title format for merge commits"
  type        = optional(string)
  default     = "MERGE_MESSAGE"
}

variable "merge_commit_message" {
  description = "Message format for merge commits"
  type        = optional(string)
  default     = "PR_TITLE"
}

variable "delete_branch_on_merge" {
  description = "Automatically delete the branch after merging"
  type        = optional(bool)
  default     = true
}

variable "has_downloads" {
  description = "Enable GitHub release downloads"
  type        = optional(bool)
  default     = true
}

variable "gitignore_template" {
  description = "Gitignore template to use (e.g., Go, Python, Node)"
  type        = optional(string)
  default     = null
}

variable "license_template" {
  description = "License template to use"
  type        = optional(string)
  default     = "agpl-3.0"
}

variable "vulnerability_alerts" {
  description = "Enable security vulnerability alerts"
  type        = optional(bool)
  default     = true
}

variable "topics" {
  description = "A list of topics for the repository (maximum 20)"
  type        = optional(list(string))
  default     = []

  validation {
    condition     = length(var.topics) <= 20 || var.topics == null
    error_message = "The 'topics' list can contain a maximum of 20 values."
  }
}