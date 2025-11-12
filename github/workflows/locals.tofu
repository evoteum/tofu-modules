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

  workflow_permissions = { for workflow, content in local.source_workflows :
    workflow => try(content.permissions, {})
  }

}
