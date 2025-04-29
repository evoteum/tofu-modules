locals {
  variable_name = "REPOSITORY_ID"
}

resource "github_actions_variable" "repo_id" {
  repository    = var.repository_name
  variable_name = local.variable_name
  value         = var.repository_id
}

resource "github_repository_custom_property" "repo_id" {
  repository     = var.repository_name
  property_name  = local.variable_name
  property_type  = "string"
  property_value = [var.repository_id]
}
