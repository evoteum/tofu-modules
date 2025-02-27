terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
    quay = {
      source = "registry.terraform.io/enthought/quay"
    }
  }
}

