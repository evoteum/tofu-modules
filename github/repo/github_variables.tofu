locals {
  quay_repository_attributes = [
    "path",
    "url",
  ]

  quay_variables = {
    for attribute in local.quay_repository_attributes :
    "quay_repository_${attribute}" => {
      scope     = var.name
      name      = "quay_repository_${attribute}"
      value     = lookup(module.quay_repository, attribute, null)
      sensitive = false
    }
  }

  repository_id_variable = {
    "repository_id" = {
      scope     = var.name
      name      = "REPOSITORY_ID"
      value     = github_repository.repo.repo_id
      sensitive = false
    }
  }

  all_github_variables = merge(
    local.quay_variables,
    local.repository_id_variable,
  )
}
