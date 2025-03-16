locals {
  source_workflows = { for workflow, content in data.github_repository_file.workflows :
    workflow => yamldecode(content.content)
  }

  # Debug output
  debug_workflows = { for workflow, content in local.source_workflows :
    workflow => {
      "raw"         = content
      "permissions" = try(content.permissions, "no permissions found")
    }
  }

  workflow_conditions = yamldecode(data.github_repository_file.workflow_conditions.content)

  environments = try(
    join(",", var.repository_configuration.environment_directories),
    var.repository_configuration.environment_directories,
    null
  )

  effective_repository_configuration = { for workflow_name, _ in data.github_repository_file.workflows :
    workflow_name => merge(
      var.repository_configuration,
      startswith(workflow_name, "tofu-") ? {
        "source_path" = "tofu"
      } : {},
      local.environments != null ? {
        "environments" = local.environments
      } : {}
    )
  }

  workflow_inputs = { for workflow, content in local.source_workflows :
    workflow => {
      for name, config in try(content.on.workflow_call.inputs, {}) :
      name => try(var.repository_configuration[name], config.default)
      if try(var.repository_configuration[name], null) != null || try(config.default, null) != null
    }
  }

  workflow_permissions = { for workflow, content in local.source_workflows :
    workflow => try(content.permissions, {})
  }

  enabled_workflows = { for workflow, condition in local.workflow_conditions :
    workflow => true
    if length(condition) > 0 && alltrue([
      for condition_key, required_value in condition :
      can(tobool(try(var.repository_configuration[condition_key], null))) && can(tobool(required_value)) ?
      tobool(try(var.repository_configuration[condition_key], null)) == tobool(required_value) :
      try(var.repository_configuration[condition_key], null) == required_value
    ])
  }
}
