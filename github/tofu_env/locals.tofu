locals {
  all_github_actions_variables = {
    for var in concat(
      data.github_actions_organization_variables.this.variables,
      data.github_actions_variables.this.variables
    ) : var.name => var
  }

  all_github_actions_secrets = {
    for secret in concat(
      data.github_actions_organization_secrets.this.secrets,
      data.github_actions_secrets.this.secrets
    ) : secret.name => secret
  }

  env_variables = {
    for var in local.all_github_actions_variables :
    "TF_VAR_${lower(var.name)}" => "$${{ vars.${upper(var.name)} }}"
  }

  env_secrets = {
    for var in local.all_github_actions_secrets :
    "TF_VAR_${lower(var.name)}" => "$${{ secrets.${upper(var.name)} }}"
  }
  env_names = merge(
    local.env_variables,
    local.env_secrets,
  )
  tofu_env = [for k, v in local.env_names : "${k}=${v}"]
}
