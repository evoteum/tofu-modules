locals {
  flattened_tags = join(",", [for k, v in var.tags : "${k}=${v}"])
}

resource "cloudflare_record" "this" {
  zone_id = var.zone_id
  name    = var.name
  content = var.value
  type    = var.type
  ttl     = 3600
  comment = local.flattened_tags
}