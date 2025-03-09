locals {
  workflows = yamldecode(data.github_repository_file.workflow_definitions.content)

  workflow_conditions = { for workflow, condition in local.workflows :
    workflow => condition
  }

  workflow_evaluations = { for workflow, condition in local.workflows :
    workflow => [
      for condition_key, required_value in condition :
      {
        condition = condition_key
        required = required_value
        provided = try(var.repository_configuration[condition_key], null)
        matches  = try(var.repository_configuration[condition_key], null) == required_value || try(var.repository_configuration[condition_key], null) == try(tobool(required_value))
      }
    ]
  }

  enabled_workflows = { for workflow, condition in local.workflows :
    workflow => true
    if length(condition) > 0 && anytrue([
      for condition_key, required_value in condition :
      try(var.repository_configuration[condition_key], null) == required_value
    ])
  }
}
