locals {
  all_github_actions_variables = distinct(concat(
    data.github_actions_organization_variables.this.variables,
    data.github_actions_variables.this.variables
  ))

  all_github_actions_secrets = distinct(concat(
    data.github_actions_organization_secrets.this.secrets,
    data.github_actions_secrets.this.secrets
  ))
  env_variables = {
    for var in local.all_github_actions_variables :
    "TF_VAR_${var.name}" => "$${{ vars.upper(var.value) }}"
  }

  env_secrets = {
    for var in local.all_github_actions_secrets :
    "TF_VAR_${var.name}" => "$${{ secrets.upper(var.value) }}"
  }
  env_names = merge(
    local.env_variables,
    local.env_secrets,
  )
  tofu_env = [for k, v in local.env_names : "${k}=${v}"]
}
