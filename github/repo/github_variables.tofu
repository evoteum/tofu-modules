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

module "github_variable" {
  source   = "github.com/evoteum/tofu-modules//github/variable"
  for_each = local.all_github_variables

  scope     = each.value.scope
  name      = each.value.name
  value     = each.value.value
  sensitive = each.value.sensitive

  depends_on = [
    module.quay_repository,
    github_repository.repo,
  ]
}