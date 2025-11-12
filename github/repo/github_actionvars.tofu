locals {
  quay_output_map = {
    path = try(module.quay_repository.path, "")
    url  = try(module.quay_repository.url, "")
  }

  quay_variables = {
    for attribute, val in local.quay_output_map :
    "quay_repository_${attribute}" => {
      scope     = var.name
      name      = "quay_repository_${attribute}"
      value     = val
      sensitive = false
    } if val != ""
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
    local.repository_id_variable,
    local.quay_variables,
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
