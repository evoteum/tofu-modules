locals {
  workflows = yamldecode(data.github_repository_file.workflow_conditions.content)
  source_workflows = { for workflow in keys(local.workflows) :
    workflow => data.github_repository_file.workflows[workflow].content
  }
  
  environment_directories = try(
    join(",", var.repository_configuration.environment_directories),
    var.repository_configuration.environment_directories,
    null
  )

  effective_repository_configuration = { for workflow_name, _ in local.workflows :
    workflow_name => merge(
      var.repository_configuration,
      startswith(workflow_name, "tofu-") ? {
        "source_path" = "tofu"
      } : {},
      local.environment_directories != null ? {
        "environment_directories" = local.environment_directories
      } : {}
    )
  }

  workflow_inputs = { for workflow, content in local.source_workflows :
    workflow => try(content.on.workflow_call.inputs, {})
  }

  workflow_permissions = { for workflow, content in local.source_workflows :
    workflow => try(content.permissions, {})
  }

  enabled_workflows = { for workflow, condition in local.workflows :
    workflow => true
    if length(condition) > 0 && alltrue([
      for condition_key, required_value in condition :
      can(tobool(try(var.repository_configuration[condition_key], null))) && can(tobool(required_value)) ?
      tobool(try(var.repository_configuration[condition_key], null)) == tobool(required_value) :
      try(var.repository_configuration[condition_key], null) == required_value
    ])
  }
}
