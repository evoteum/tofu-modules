terraform {
  required_providers {
    quay = {
      source = "registry.terraform.io/enthought/quay"
    }
  }
}

resource "quay_repository" "repo" {
  namespace      = var.organization
  name           = var.name
  visibility     = var.visibility
  description    = var.description
  tags_immutable = true
  scanning_configuration {
    enabled = true
  }
} 