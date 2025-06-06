locals {
  certificate_dns_records = {
    for idx, dvo in module.aws_certificate.domain_validation_options :
    "cert_record_${idx}" => {
      zone_id = module.cloudflare_zone.id
      name    = dvo.name
      type    = dvo.type
      value   = dvo.value
      proxied = false
      ttl     = 60
    }
  }

  alb_dns_records = {
    www = {
      zone_id = module.cloudflare_zone.id
      name    = "www"
      type    = "CNAME"
      value   = var.alb_dns_name
      proxied = false
      ttl     = 60
    },
    root = {
      zone_id = module.cloudflare_zone.id
      name    = "@"
      type    = "CNAME"
      value   = "www.${local.clean_host.domain}"
      proxied = true
      ttl     = 1
    },
  }

  all_dns_records = merge(
    local.certificate_dns_records,
    local.alb_dns_records,
  )
}

module "cloudflare_zone" {
  source = "github.com/evoteum/tofu-modules//cloudflare/zone"

  account_id  = var.cloudflare_account_id
  domain_name = var.homepage_url
}

module "cloudflare_record" {
  source   = "github.com/evoteum/tofu-modules//cloudflare/record"
  for_each = local.all_dns_records

  zone_id      = module.cloudflare_zone.id
  name         = each.value.name
  type         = each.value.type
  value        = each.value.value
  proxied      = each.value.proxied
  time_to_live = each.value.ttl
  tags = {
    repository_url = var.repository_url
    ManagedBy      = "OpenTofu"
  }
  depends_on = [
    module.aws_certificate
  ]
}
