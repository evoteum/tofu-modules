terraform {
  required_providers {
    quay = {
      source = "registry.terraform.io/enthought/quay"
    }
  }
}



resource "quay_repository" "repo" {
  name        = var.name
  namespace   = var.organisation
  visibility  = var.visibility
  description = var.description
} 