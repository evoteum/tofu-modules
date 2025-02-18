variable "bucket_suffix_length" {
    type        = number
    description = "The length of the random string to append to the bucket name."
    default     = 16
    sensitive   = false
}

variable "bucket_name" {
    type        = string
    description = "The name of the S3 bucket."
    sensitive   = false
}

variable "org_domain" {
    type        = string
    description = "The domain name of the organisation eg example.com"
    sensitive   = false
}

variable "project" {
    type        = string
    description = "The name of the project."
    sensitive   = false
}

variable "environment" {
    type        = string
    description = "The environment to deploy the infrastructure to."
    sensitive   = false
}

variable "purpose" {
    type        = string
    description = "What is this S3 bucket for?"
    sensitive   = false
}