output "name" {
  description = "The name of the created repository"
  value       = quay_repository.repo.name
}

output "url" {
  description = "The URL of the created repository"
  value       = "quay.io/${var.organisation}/${quay_repository.repo.name}"
} 