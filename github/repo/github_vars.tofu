resource "github_actions_variable" "fail_fast" {
  repository    = github_repository.repo.name
  variable_name = "FAIL_FAST"
  value         = var.fail_fast
}

resource "github_actions_variable" "quay_repo_url" {
  for_each = local.needs_container ? { "quay_repo_url" = {} } : {}
  depends_on = [
    module.quay_repository["repo"].url
  ]

  repository    = github_repository.repo.name
  value         = module.quay_repository["repo"].url
  variable_name = "QUAY_REPO_URL"
}
