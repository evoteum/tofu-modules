locals {

  repository_variables = {
    for var in data.github_actions_variables.this.variables :
      "TF_VAR_${lower(var.name)}" => var.name
  }
  organisation_variables = {
    for var in data.github_actions_organization_variables.this.variables :
      "TF_VAR_${lower(var.name)}" => var.name
  }

  all_variables = merge(
    local.repository_variables,
    local.organisation_variables,
  )

  tofu_env = join("\n", [for k, v in local.all_variables : "${k}=${v}"])
}
