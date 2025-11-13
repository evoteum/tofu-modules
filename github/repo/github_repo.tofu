resource "github_repository" "repo" {
  name                        = var.name
  description                 = var.description
  homepage_url                = var.homepage_url
  visibility                  = var.visibility
  has_issues                  = var.has_issues
  has_discussions             = var.has_discussions
  has_projects                = var.has_projects
  has_wiki                    = var.has_wiki
  is_template                 = false
  allow_merge_commit          = var.allow_merge_commit
  allow_squash_merge          = var.allow_squash_merge
  allow_rebase_merge          = var.allow_rebase_merge
  allow_auto_merge            = var.allow_auto_merge
  squash_merge_commit_title   = var.squash_merge_commit_title
  squash_merge_commit_message = var.squash_merge_commit_message
  merge_commit_title          = var.merge_commit_title
  merge_commit_message        = var.merge_commit_message
  delete_branch_on_merge      = var.delete_branch_on_merge
  web_commit_signoff_required = false
  has_downloads               = var.has_downloads
  auto_init                   = false
  gitignore_template          = var.gitignore_template
  license_template            = var.license_template
  archived                    = var.archived
  archive_on_destroy          = true
  vulnerability_alerts        = var.vulnerability_alerts
  topics                      = var.topics

  dynamic "pages" {
    for_each = var.has_pages ? [1] : []
    content {
      build_type = var.pages_build_type
      cname      = var.pages_cname

      dynamic "source" {
        for_each = var.pages_build_type == "legacy" ? [1] : []
        content {
          branch = var.pages_source_branch
          path   = var.pages_source_path
        }
      }
    }
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "github_branch" "main" {
  depends_on = [
    github_repository.repo
  ]
  branch     = var.trunk_branch_name
  repository = github_repository.repo.name
  lifecycle {
    prevent_destroy = true
  }
}

resource "github_branch_default" "main" {
  depends_on = [
    github_branch.main
  ]
  branch     = github_branch.main.branch
  repository = github_branch.main.repository
  lifecycle {
    prevent_destroy = true
  }
}
