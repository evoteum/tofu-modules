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

  all_github_variables = merge(
    local.quay_variables,
  )

}
