locals {

  repository_variables = {
    for var in data.github_actions_variables.this.variables :
      "TF_VAR_${lower(var.name)}" => "$${{ vars.${upper(var.name)} }}"
  }
  organisation_variables = {
    for var in data.github_actions_organization_variables.this.variables :
      "TF_VAR_${lower(var.name)}" => "$${{ vars.${upper(var.name)} }}"
  }
    repository_secrets = {
    for var in data.github_actions_secrets.this.secrets :
      "TF_VAR_${lower(var.name)}" => "$${{ secrets.${upper(var.name)} }}"
  }
  organisation_secrets = {
    for var in data.github_actions_organization_secrets.this.secrets :
      "TF_VAR_${lower(var.name)}" => "$${{ secrets.${upper(var.name)} }}"
  }

  all_variables = merge(
    local.repository_variables,
    local.organisation_variables,
  )
  all_secrets = merge(
    local.repository_secrets,
    local.organisation_secrets,
  )
  env_names = merge(
    local.all_variables,
    local.all_secrets,
  )
  tofu_env = [for k, v in local.env_names : "${k}=${v}"]
}
