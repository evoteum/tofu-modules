locals {
  flattened_tags = [for k, v in var.tags : "${k}:${v}"]
}

resource "cloudflare_record" "this" {
  zone_id = var.zone_id
  name    = var.name
  content = var.value
  type    = var.type
  ttl     = 3600
  tags    = local.flattened_tags
}