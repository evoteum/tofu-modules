terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "4.52.0"
    }
  }
}


locals {

}

resource "cloudflare_page_rule" "redirect" {
  zone_id = var.zone_id
  target  = var.from_domain

  actions {
    forwarding_url {
      url         = var.to_url
      status_code = 301
    }
  }
  priority = var.priority
}
