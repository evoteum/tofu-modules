variable "aws_region" {
  type        = string
  description = "The AWS region to deploy the infrastructure to."
  sensitive   = false
}



variable "org_name" {
  type        = string
  description = "The name of the organisation."
  sensitive   = false
}

variable "org_slogan" {
  type        = string
  description = "The slogan of the organisation."
  sensitive   = false
  default     = "Innovation Evolution"
}

variable "repo_name" {
  type        = string
  description = "The name of the repository."
  sensitive   = false
}

variable "environment" {
    type        = string
    description = "The environment to deploy to."
    sensitive   = false
}