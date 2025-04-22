variable "domain_name" {
  description = "The domain name to associate with this certificate"
  type        = string
}

variable "subject_alternative_names" {
  type        = list(string)
  default     = null
  description = "allow you to secure multiple subdomains from one certificate, eg, api.example.com www..example.com"
}