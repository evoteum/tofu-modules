output "organization_name" {
  description = "The name of the created organization"
  value       = quay_organization.org.name
}

output "organization_url" {
  description = "The URL of the created organization"
  value       = "quay.io/${quay_organization.org.name}"
}
