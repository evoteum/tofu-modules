terraform {
  required_providers {
    quay = {
      source = "registry.terraform.io/enthought/quay"
    }
  }
}

resource "quay_repository" "prevent_destroy" {
  for_each    = var.prevent_destroy ? { "repo" = true } : {}
  name        = var.name
  namespace   = var.organisation
  visibility  = var.visibility
  description = var.description
  lifecycle {
    prevent_destroy = true
  }
}

resource "quay_repository" "allow_destroy" {
  for_each    = var.prevent_destroy ? {} : { "repo" = true }
  name        = var.name
  namespace   = var.organisation
  visibility  = var.visibility
  description = var.description
  lifecycle {
    prevent_destroy = false
  }
}
