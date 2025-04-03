locals {
  repo = merge(
    quay_repository.prevent_destroy,
    quay_repository.allow_destroy,
  )
  repo_name = values(local.repo)[0].name

}

output "name" {
  description = "The name of the created repository"
  value       = local.repo_name
}

output "url" {
  description = "The URL of the created repository, for use with HTML hyperlinks"
  value       = "${var.quay_url}/repository/${var.organisation}/${local.repo_name}"
}

output "path" {
  description = "The path of the created repository, for use with podman & containers"
  value       = "${var.quay_domain}/${var.organisation}/${local.repo_name}"
}

