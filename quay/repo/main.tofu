terraform {
  required_providers {
    quay = {
      source = "enthought/quay"
    }
  }
}

resource "quay_repository" "repo" {
  namespace      = var.organization
  name           = var.repository_name
  visibility     = var.visibility
  description    = var.description
  tags_immutable = true
  scanning_configuration {
    enabled = true
  }
} 