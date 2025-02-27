resource "github_actions_variable" "fail_fast" {
  repository    = github_repository.repo.name
  variable_name = "FAIL_FAST"
  value         = var.fail_fast
}
