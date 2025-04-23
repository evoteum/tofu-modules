resource "cloudflare_zone" "this" {
  account_id = var.account_id
  zone       = local.domain_name_parsed
  type       = "full"
}
