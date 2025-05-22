variable "domain_name" {
  description = "The domain name to associate with this certificate"
  type        = string
}

variable "subject_alternative_names" {
  type        = list(string)
  default     = []
  description = "Optional additional domain names to secure, such as www.example.com or api.example.com"
}
