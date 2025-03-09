resource "github_repository_file" "generated_callers" {
  for_each   = local.enabled_workflows
  depends_on = [data.github_repository_file.workflow_definitions]

  repository = var.repository
  file       = ".github/workflows/${each.key}.yml"

  content = templatefile("${path.module}/templates/generic-caller.yml", {
    CONTROLLER_REPO_NAME          = var.controller_repo_name
    REUSABLE_WORKFLOWS_REPOSITORY = var.reusable_workflows_repository
    SOURCE_PATH                   = startswith(each.key, "tofu-") ? "tofu" : lookup(var.repository_configuration[condition_key], "source_path", "*")
    WORKFLOW_NAME                 = each.key
  })

  commit_message      = "Update content"
  overwrite_on_create = true
}