locals {
  workflows = yamldecode(data.github_repository_file.workflow_definitions.content)

  enabled_workflows = { for key, workflow in local.workflows :
    key => true
    if length(workflow) > 0 && alltrue([
      for condition_key, required_value in workflow :
      try(var.repository_configuration[condition_key], null) == required_value
    ])
  }
}