locals {
  domain_name_host = provider::netparse::parse_url(var.domain_name).host
  subject_alternative_names_host = toset([
    for s in var.subject_alternative_names : provider::netparse::parse_url(s).host
  ])

}
