locals {
  is_tofu_workflow = { for name in keys(local.source_workflows) :
    name => can(regex("^tofu-", name))
  }
  workflow_cron_expression = { for name, condition in local.source_workflows :
    name => lookup(
      var.repository_configuration,
      local.is_tofu_workflow[name] ? "tofu_build_schedule" : "app_build_schedule",
      null
    )
    if lookup(
      var.repository_configuration,
      local.is_tofu_workflow[name] ? "tofu_build_schedule" : "app_build_schedule",
      null
    ) != null
  }
  workflow_cron_description = { for name, cron in local.workflow_cron_expression :
    name => lookup(local.cron_schedules, cron, "Custom schedule")
  }

}

data "jinja_template" "workflow" {
  for_each = local.enabled_workflows

  context {
    type = "json"
    data = jsonencode({
      workflow_name            = each.key
      controller_repo_name     = var.controller_repo_name
      cron_description         = lookup(local.workflow_cron_description, each.key, "Custom schedule")
      cron_expression          = lookup(local.workflow_cron_expression, each.key, null)
      last_updated             = timestamp()
      organisation             = var.organisation
      repository_configuration = local.effective_repository_configuration[each.key]
      reusable_workflows_repo  = var.reusable_workflows_repository
      source_path              = lookup(var.repository_configuration, "source_path", "*")
      workflow_inputs          = local.workflow_inputs[each.key]
      workflow_permissions     = local.workflow_permissions[each.key]
    })
  }

  source {
    template  = file("${path.module}/templates/reusable-workflow-caller.yml.j2")
    directory = path.module
  }
}

resource "github_repository_file" "caller_workflow" {
  for_each   = local.enabled_workflows
  depends_on = [data.github_repository_file.workflow_conditions]

  repository = var.repository
  file       = ".github/workflows/${each.key}.yml"
  content    = data.jinja_template.workflow[each.key].result

  commit_message      = "Update workflow"
  overwrite_on_create = true
}