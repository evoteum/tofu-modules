locals {
  domain_name_host = provider::netparse::parse_url(var.domain_name).host

  subject_alternative_names_host = (
    var.subject_alternative_names == null || length(var.subject_alternative_names) == 0
    ? ["www.${local.domain_name_host}"]
    : [
      for s in var.subject_alternative_names : provider::netparse::parse_url(s).host
    ]
  )
}
