resource "cloudflare_zone" "this" {
  account = {
    id = var.account_id
  }
  name = var.domain_name
  type = "full"
}
