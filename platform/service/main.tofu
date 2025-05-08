terraform {
  required_version = "1.9.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    cloudflare = {
      source = "cloudflare/cloudflare"
      # Thow shalt not upgrade to v5 lest ye seeketh chaos, confusion and dragons. Ye be warned.
      version = "4.52.0"
    }
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
    netparse = {
      source  = "gmeligio/netparse"
      version = "0.0.3"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.6.0"
    }
    quay = {
      source = "registry.terraform.io/enthought/quay"
    }
  }
}
