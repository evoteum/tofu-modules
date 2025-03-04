locals {
  org_variable  = local.is_org_scope && !var.sensitive ? { var.name = var.value } : {}
  repo_variable = local.is_repo_scope && !var.sensitive ? { var.name = { repository = var.scope, value = var.value } } : {}
}

resource "github_actions_variable" "repo_variable" {
  for_each      = local.repo_variable
  repository    = var.scope
  variable_name = var.name
  value         = var.value
}

resource "github_actions_organization_variable" "org_variable" {
  for_each      = local.org_variable
  variable_name = var.name
  visibility    = "all"
  value         = var.value

}
