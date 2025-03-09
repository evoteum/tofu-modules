output "debug" {
  value =  {
    raw_workflows = data.github_repository_file.workflow_definitions.content
    workflow_conditions = local.workflow_conditions
    repo_config = var.repository_configuration
    workflow_evaluations = local.workflow_evaluations
    enabled_workflows = local.enabled_workflows
  }
}