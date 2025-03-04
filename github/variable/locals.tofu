locals {
  is_org_scope  = var.scope == "organisation"
  is_repo_scope = !local.is_org_scope
}