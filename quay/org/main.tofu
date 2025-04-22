terraform {
  required_providers {
    quay = {
      source = "enthought/quay"
    }
  }
}

resource "quay_organization" "org" {
  name  = var.organisation
  email = var.email
}
