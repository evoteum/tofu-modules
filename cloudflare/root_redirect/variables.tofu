variable "from_domain" {
  description = "The domain name to that we are redirecting from"
  type        = string
}

variable "priority" {
  description = "The priority that this rule should be set at"
  type        = number
  default     = 1
}

variable "to_url" {
  description = "The URL that we are redirecting to"
  type        = string
  default     = "www."
}

variable "zone_id" {
  description = "ID of the zone that the domain is in"
  type        = string
}
