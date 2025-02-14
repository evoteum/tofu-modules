terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 5.0"
    }
  }
}


resource "github_repository" "repo" {
  name                        = var.repo_name
  description                 = var.repo_description
  homepage_url                = var.homepage_url != null ? var.homepage_url : null
  visibility                  = var.visibility != null ? var.visibility : null
  has_issues                  = var.has_issues != null? var.has_issues : null
  has_discussions             = var.has_discussions != null? var.has_discussions : null
  has_projects                = var.has_projects != null? var.has_projects : null
  has_wiki                    = var.has_wiki != null? var.has_wiki : null
  is_template                 = false
  allow_merge_commit          = var.allow_merge_commit != null? var.allow_merge_commit : null
  allow_squash_merge          = var.allow_squash_merge != null? var.allow_squash_merge : null
  allow_rebase_merge          = var.allow_rebase_merge != null? var.allow_rebase_merge : null
  allow_auto_merge            = var.allow_auto_merge != null? var.allow_auto_merge : null
  squash_merge_commit_title   = var.squash_merge_commit_title != null? var.squash_merge_commit_title : null
  squash_merge_commit_message = var.squash_merge_commit_message != null? var.squash_merge_commit_message : null
  merge_commit_title          = var.merge_commit_title != null? var.merge_commit_title : null
  merge_commit_message        = var.merge_commit_message != null? var.merge_commit_message : null
  delete_branch_on_merge      = var.delete_branch_on_merge != null? var.delete_branch_on_merge : null
  web_commit_signoff_required = false
  has_downloads               = var.has_downloads != null? var.has_downloads : null
  auto_init                   = false
  gitignore_template          = var.gitignore_template != null? var.gitignore_template : null
  license_template            = var.license_template != null? var.license_template : null
  archive_on_destroy          = true
  vulnerability_alerts        = var.vulnerability_alerts != null? var.vulnerability_alerts : null
  topics                      = var.topics != null? var.topics : null

  lifecycle {
    ignore_changes = [
      archived
    ]
  }
}

resource "github_branch" "main" {
  branch     = "main"
  repository = github_repository.repo.name
}

resource "github_branch_default" "main" {
  branch     = github_branch.main.branch
  repository = github_branch.main.repository
}

resource "github_repository_file" "readme" {
  depends_on = [
    github_branch_default.main
  ]
  repository = var.repo_name
  file       = "README.md"
  content = templatefile("${path.module}/README.md.template", {
    REPO_NAME        = var.repo_name,
    REPO_DESCRIPTION = var.repo_description
  })
  commit_message = "Initialize README.md"

  lifecycle {
    create_before_destroy = true
    ignore_changes = [
      content,
    ]
  }
}