resource "github_repository_file" "readme" {
  depends_on = [
    github_branch_default.main
  ]
  repository = github_repository.repo.name
  file       = "README.md"
  content = templatefile("${path.module}/templates/README.md", {
    NAME                 = var.name,
    DESCRIPTION          = var.description,
    CONTROLLER_REPO_LINK = local.controller_repo_link,
  })
  commit_message      = "Initial commit"
  overwrite_on_create = true
  lifecycle {
    create_before_destroy = true
    prevent_destroy       = true
    ignore_changes = [
      content,
    ]
  }
}
