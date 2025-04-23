terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "4.52.0"
    }
    netparse = {
      source  = "gmeligio/netparse"
      version = "0.0.3"
    }
  }
}

