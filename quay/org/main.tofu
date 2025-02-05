terraform {
  required_providers {
    quay = {
      source = "enthought/quay"
    }
  }
}

resource "quay_organization" "org" {
  name        = var.organization_name
  email       = var.email
  visibility  = var.visibility
  description = var.description
}
