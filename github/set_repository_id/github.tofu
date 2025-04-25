locals {
  variable_name = "REPOSITORY_ID"
}

resource "github_actions_variable" "repo_id" {
  repository    = data.github_repository.this.name
  variable_name = local.variable_name
  value         = tostring(data.github_repository.this.repo_id)
}

resource "github_repository_custom_property" "repo_id" {
  repository     = data.github_repository.this.name
  property_name  = local.variable_name
  property_type  = "string"
  property_value = [tostring(data.github_repository.this.repo_id)]
}
