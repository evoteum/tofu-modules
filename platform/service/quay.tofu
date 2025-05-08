locals {
  repository_archived    = var.repository_archived ? "Archived: " : ""
  repository_description = "${local.repository_archived}${var.repository_description} ${var.repository_url}"
}

module "quay_repository" {
  source = "github.com/evoteum/tofu-modules//quay/repo"

  name         = var.repository_name
  organisation = var.organisation
  visibility   = var.repository_visibility
  description  = local.repository_description
}
