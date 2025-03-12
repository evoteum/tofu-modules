locals {
  workflows = yamldecode(data.github_repository_file.workflow_conditions.content)
  source_workflows = { for workflow in keys(local.workflows) :
    workflow => data.github_repository_file.workflows[workflow].content
  }

  workflow_inputs = { for workflow, content in local.source_workflows :
    workflow => try(content.on.workflow_call.inputs, {})
  }

  workflow_permissions = { for workflow, content in local.source_workflows :
    workflow => try(content.permissions, {})
  }

  enabled_workflows = { for workflow, condition in local.workflows :
    workflow => true
    if length(condition) > 0 && anytrue([
      for condition_key, required_value in condition :
      can(tobool(try(var.repository_configuration[condition_key], null))) && can(tobool(required_value)) ?
      tobool(try(var.repository_configuration[condition_key], null)) == tobool(required_value) :
      try(var.repository_configuration[condition_key], null) == required_value
    ])
  }
}
