locals {
  quay_domain_elements = split(var.quay_url, "/")
  quay_domain = reverse(local.quay_domain_elements)[0]
  container_readme = "Containers are published on [${local.quay_domain}](${module.quay_repository["repo"].url})"
  container_repo_link = var.artifact_type == "container" ? local.container_readme : ""
}

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

  lifecycle {
    prevent_destroy = true
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

resource "github_repository_file" "readme" {
  depends_on = [
    github_branch_default.main
  ]
  repository = github_repository.repo.name
  file       = "README.md"
  content = templatefile("${path.module}/templates/README.md.tftpl", {
    NAME                 = var.name,
    CONTAINER_REPO_LINK  = local.container_repo_link,
    DESCRIPTION          = var.description,
    MANAGEMENT_REPO_NAME = var.management_repo_name,
    MANAGEMENT_REPO_URL  = var.management_repo_url,
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