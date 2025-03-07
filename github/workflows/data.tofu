data "github_repository" "workflows" {
  name = var.reusable_workflows_repository
}

data "github_repository_file" "workflow_definitions" {
  repository = data.github_repository.workflows.name
  file       = var.workflow_definitions
}

data "github_repository_file" "workflows" {
  for_each   = yamldecode(data.github_repository_file.workflow_definitions.content)
  repository = data.github_repository.workflows.name
  file       = ".github/workflows/${each.key}.yml"
}
