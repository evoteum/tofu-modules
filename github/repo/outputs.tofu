output "id" {
  description = "The ID of the created GitHub repository"
  value       = github_repository.repo.id
}

output "name" {
  description = "The name of the created GitHub repository"
  value       = github_repository.repo.name
}

output "url" {
  description = "The web URL of the GitHub repository"
  value       = github_repository.repo.html_url
}

output "clone_url" {
  description = "The HTTPS clone URL of the repository"
  value       = github_repository.repo.http_clone_url
}

output "ssh_clone_url" {
  description = "The SSH clone URL of the repository"
  value       = github_repository.repo.ssh_clone_url
}

output "git_clone_url" {
  description = "The Git clone URL of the repository"
  value       = github_repository.repo.git_clone_url
}

output "full_name" {
  description = "The full name of the repository (org/repo-name)"
  value       = github_repository.repo.full_name
}

output "visibility" {
  description = "The visibility of the repository (public/private)"
  value       = github_repository.repo.visibility
}

output "archived" {
  description = "Whether the repository is archived"
  value       = github_repository.repo.archived
}

output "topics" {
  description = "List of topics assigned to the repository"
  value       = github_repository.repo.topics
}