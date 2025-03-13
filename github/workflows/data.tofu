data "github_repository" "reusable_workflows" {
  name = var.reusable_workflows_repository
}

data "github_repository_file" "workflow_conditions" {
  repository = data.github_repository.reusable_workflows.name
  file       = var.workflow_conditions
}

data "github_repository_file" "workflows" {
  for_each   = local.workflow_conditions
  repository = data.github_repository.reusable_workflows.name
  file       = ".github/workflows/${each.key}.yml"
}
