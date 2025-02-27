locals {
  quay_description = "${var.archived ? "Archived: " : ""}${var.description} ${github_repository.repo.html_url}"
}

module "quay_repository" {
  source   = "github.com/evoteum/tofu-modules.git//quay/repo"
  for_each = var.artifact_type == "container" ? { "repo" = {} } : {}

  name         = var.name
  organisation = var.organisation
  visibility   = var.visibility
  description  = local.quay_description
  lifecycle {
    prevent_destroy = true
  }
}
