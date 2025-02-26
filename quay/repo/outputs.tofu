output "repository_name" {
  description = "The name of the created repository"
  value       = quay_repository.repo.name
}

output "repository_url" {
  description = "The URL of the created repository"
  value       = "quay.io/${var.organization}/${quay_repository.repo.name}"
} 