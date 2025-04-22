resource "cloudflare_zone" "service" {
  account_id = var.account_id
  zone       = var.domain_name
  type       = "full"
}
