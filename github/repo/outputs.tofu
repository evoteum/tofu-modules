output "repo_id" {
  description = "The ID of the created GitHub repository"
  value       = github_repository.repo.id
}

output "repo_name" {
  description = "The name of the created GitHub repository"
  value       = github_repository.repo.name
}

output "repo_url" {
  description = "The web URL of the GitHub repository"
  value       = github_repository.repo.html_url
}

output "repo_clone_url" {
  description = "The HTTPS clone URL of the repository"
  value       = github_repository.repo.http_clone_url
}

output "repo_ssh_clone_url" {
  description = "The SSH clone URL of the repository"
  value       = github_repository.repo.ssh_clone_url
}

output "repo_git_clone_url" {
  description = "The Git clone URL of the repository"
  value       = github_repository.repo.git_clone_url
}

output "repo_full_name" {
  description = "The full name of the repository (org/repo-name)"
  value       = github_repository.repo.full_name
}

output "repo_visibility" {
  description = "The visibility of the repository (public/private)"
  value       = github_repository.repo.visibility
}

output "repo_archived" {
  description = "Whether the repository is archived"
  value       = github_repository.repo.archived
}

output "repo_topics" {
  description = "List of topics assigned to the repository"
  value       = github_repository.repo.topics
}