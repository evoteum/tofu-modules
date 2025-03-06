locals {
  repo_secret = local.is_repo_scope && var.sensitive ? { (var.name) : { repository = var.scope, value = var.value } } : {}
  org_secret  = local.is_org_scope && var.sensitive ? { (var.name) : var.value } : {}
}

resource "github_actions_secret" "repo_secret" {
  for_each        = local.repo_secret
  repository      = var.scope
  secret_name     = local.name
  plaintext_value = var.value
}

resource "github_actions_organization_secret" "org_secret" {
  for_each        = local.org_secret
  secret_name     = local.name
  plaintext_value = var.value
  visibility      = "all"
}
