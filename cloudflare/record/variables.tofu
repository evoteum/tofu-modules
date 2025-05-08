variable "type" {
  description = "The type of DNS record that we are managing"
  type        = string

  validation {
    condition = contains([
      "A", "AAAA", "CAA", "CNAME", "TXT", "SRV", "LOC", "MX", "NS", "SPF",
      "CERT", "DNSKEY", "DS", "NAPTR", "SMIMEA", "SSHFP", "TLSA", "URI",
      "PTR", "HTTPS", "SVCB"
    ], var.type)
    error_message = "record_type must be one of: A, AAAA, CAA, CNAME, TXT, SRV, LOC, MX, NS, SPF, CERT, DNSKEY, DS, NAPTR, SMIMEA, SSHFP, TLSA, URI, PTR, HTTPS, or SVCB."
  }
}

variable "value" {
  description = "The value of the DNS record that we are applying"
  type        = string
}

variable "comment" {
  description = "Comments or notes about the DNS record. This field has no effect on DNS responses."
  default     = ""
  type        = string
}

variable "time_to_live" {
  description = "Time To Live (TTL) of the DNS record in seconds. Setting to 1 means 'automatic'. Value must be between 60 and 86400"
  default     = 1
  type        = number
  nullable    = false
}

variable "tags" {
  type        = map(string)
  description = "Custom tags for the DNS record. This field has no effect on DNS responses. Maximum 100 characters total."
  default     = {}
}

variable "proxied" {
  type        = bool
  description = "Whether the record is receiving the performance and security benefits of Cloudflare."
  default     = true
  nullable    = false
}

variable "name" {
  type        = string
  description = "DNS record name (or @ for the zone apex) in Punycode"
  default     = "@"
  nullable    = false
}

variable "zone_id" {
  description = "ID of the zone that the domain is in"
  type        = string
}
