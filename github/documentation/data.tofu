# ORGANISATION_SECRET_NAMES
data "github_actions_organization_secrets" "this" {
}

# ORGANISATION_VARIABLE_NAMES
data "github_actions_organization_variables" "this" {
}

# REPOSITORY_SECRET_NAMES
data "github_actions_secrets" "this" {
  name = var.repository_name
}

# REPOSITORY_VARIABLE_NAMES
data "github_actions_variables" "this" {
  name = var.repository_name
}
