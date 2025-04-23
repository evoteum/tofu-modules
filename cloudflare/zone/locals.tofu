locals {
  domain_name_parsed = provider::netparse::parse_url(var.domain_name).host
}