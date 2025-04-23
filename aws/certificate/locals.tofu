locals {
  subject_alternative_names_host = var.subject_alternative_names == null ? [] : toset([
    for s in var.subject_alternative_names : provider::netparse::parse_url(s).host
  ])
  domain_name_host = provider::netparse::parse_url(var.domain_name).host

}
