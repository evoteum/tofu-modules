resource "github_repository_file" "generated_callers" {
  for_each   = local.workflows_with_inputs
  depends_on = [data.github_repository_file.workflow_definitions]

  repository = var.repo_name
  file       = ".github/workflows/${each.key}.yml"

  content = templatefile("${path.module}/templates/generic-caller.yml", {
    CONTROLLER_REPO_NAME = var.controller_repo_name
    INPUTS               = join("\n", [for key, value in local.workflow_inputs[each.key] : "      ${key}: \"${value}\""])
    SOURCE_PATH          = strcontains(each.key, "tofu") ? "tofu" : var.source_path
    WORKFLOW_NAME        = each.key
  })

  commit_message      = "Update content"
  overwrite_on_create = true
}