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

  lifecycle {
    ignore_changes = [
      archived
    ]
  }
}

resource "github_branch" "main" {
  depends_on = [
    github_repository.repo
  ]
  branch     = var.trunk_branch_name
  repository = github_repository.repo.name
}

resource "github_branch_default" "main" {
  depends_on = [
    github_branch.main
  ]
  branch     = github_branch.main.branch
  repository = github_branch.main.repository
}

resource "github_repository_file" "readme" {
  depends_on = [
    github_branch_default.main
  ]
  repository = github_repository.repo.name
  file       = "README.md"
  content = templatefile("${path.module}/README.md.template", {
    REPO_NAME            = var.repo_name,
    REPO_DESCRIPTION     = var.repo_description,
    MANAGEMENT_REPO_NAME = var.management_repo_name,
    MANAGEMENT_REPO_URL  = var.management_repo_url,
  })
  commit_message = "Initial commit"

  lifecycle {
    create_before_destroy = true
    ignore_changes = [
      content,
    ]
  }
}

resource "github_repository_file" "tofu_main" {
  count = var.include_tofu ? 1 : 0
  content = templatefile("${path.module}/main.tofu.template", {
  })
  file       = "tofu/main.tofu"
  repository = github_repository.repo.name
  commit_message = "Initial commit"

  lifecycle {
    create_before_destroy = true
    ignore_changes = [
      content,
    ]
  }
}

resource "github_repository_file" "tofu_apply" {
  count = var.include_tofu ? 1 : 0
  content    = templatefile("${path.module}/tofu-apply.yml.template", {
  })
  file       = ".github/workflows/tofu-apply.yml"
  repository = github_repository.repo.name
  commit_message = "Initial commit"

  lifecycle {
    create_before_destroy = true
    ignore_changes = [
      content,
    ]
  }
}
