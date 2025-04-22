resource "cloudflare_zone" "this" {
  account = {
    id = var.account_id
  }
  zone       = var.domain_name
  type       = "full"
}
