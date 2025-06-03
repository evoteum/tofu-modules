locals {
  url        = provider::netparse::parse_url(var.homepage_url)
  clean_host = provider::netparse::parse_domain(local.url.host)
}
