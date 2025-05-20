locals {
  md5_hash         = md5(var.host)
  numeric_hash     = join("", [for c in split("", local.md5_hash) : c if can(regex("[0-9]", c))])
  default_priority = tonumber(substr(local.numeric_hash, 0, 6)) % 50000 + 1
  priority         = var.priority != null ? var.priority : local.default_priority
  url              = provider::netparse::parse_url(var.host)
  clean_host       = provider::netparse::parse_domain(local.url.host)
}
