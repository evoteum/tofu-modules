locals {
  container_repo_link  = var.quay_repository_url == null || var.quay_repository_url == "" ? "" : "[${var.quay_domain}](${var.quay_repository_url})"
  controller_repo_link = var.management_repo_name == "" ? "" : " in the [${var.management_repo_name}](${var.management_repo_url}) repository"

  github_organisation_secret_names = join("\n", [
    for name in sort([
      for v in data.github_actions_organization_secrets.this.secrets : v.name
    ]) : "- `${name}`"
  ])

  github_organisation_variable_names = join("\n", [
    for name in sort([
      for v in data.github_actions_organization_variables.this.variables : v.name
    ]) : "- `${name}`"
  ])

  github_repository_secret_names = join("\n", [
    for name in sort([
      for v in data.github_actions_secrets.this.secrets : v.name
    ]) : "- `${name}`"
  ])

  github_repository_variable_names = join("\n", [
    for name in sort([
      for v in data.github_actions_variables.this.variables : v.name
    ]) : "- `${name}`"
  ])

}

