data "jinja_template" "workflow" {
  for_each = local.enabled_workflows

  context {
    type = "yaml"
    data = yamlencode({
      workflow_name                 = each.key
      reusable_workflows_repository = var.reusable_workflows_repository
      source_path                   = startswith(each.key, "tofu-") ? "tofu" : lookup(var.repository_configuration, "source_path", "*")
      workflow_inputs               = local.workflow_inputs[each.key]
      workflow_permissions          = local.workflow_permissions[each.key]
      repository_configuration      = var.repository_configuration
      cron_schedules                = local.cron_schedules
      owner                         = var.organisation
    })
  }

  source {
    template  = file("${path.module}/templates/generic-caller.yml.j2")
    directory = "${path.module}/templates"
  }
}

resource "github_repository_file" "caller_workflow" {
  for_each   = local.enabled_workflows
  depends_on = [data.github_repository_file.workflow_definitions]

  repository = var.repository
  file       = ".github/workflows/${each.key}.yml"
  content    = data.jinja_template.workflow[each.key].result

  commit_message      = "Update content"
  overwrite_on_create = true
}