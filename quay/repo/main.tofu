terraform {
  required_providers {
    quay = {
      source = "registry.terraform.io/enthought/quay"
    }
  }
}

provider "quay" {
  url = var.quay_url
}

resource "quay_repository" "repo" {
  name           = var.name
  namespace      = var.organization
  visibility     = var.visibility
  description    = var.description
} 