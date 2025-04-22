resource "cloudflare_zone" "this" {
  account = var.account_id
  zone       = var.domain_name
  type       = "full"
}
