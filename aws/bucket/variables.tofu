variable "archive_days" {
  type        = number
  description = "Number of days after which to transition current version to DEEP_ARCHIVE. null = do not archive, keep all files in STANDARD"
  sensitive   = false
  default     = null
  validation {
    condition     = var.archive_days == null || try(var.archive_days >= 0, true)
    error_message = "archive_days must be null or a non-negative integer."
  }
}

variable "bucket_suffix_length" {
  type        = number
  description = "The length of the random string to append to the bucket name."
  default     = 8
  sensitive   = false
}

variable "environment" {
  type        = string
  description = "The environment to deploy the infrastructure to."
  sensitive   = false
}

variable "noncurrent_version_expiration_days" {
  type        = number
  description = "Number of days to keep noncurrent file versions"
  sensitive   = false
  default     = 90
}

variable "organisation" {
  type        = string
  description = "The name of the organisation"
  sensitive   = false
}

variable "project" {
  type        = string
  description = "The name of the project."
  sensitive   = false
}

variable "purpose" {
  type        = string
  description = "What is this S3 bucket for? Ideally one or two words"
  sensitive   = false
}
