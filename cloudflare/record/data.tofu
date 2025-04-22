data "cloudflare_zone" "this" {
  filter {
    name {
      equal = var.domain
    }
  }
}
