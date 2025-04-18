output "service_url" {
  description = "The URL of the App Runner service"
  value       = aws_apprunner_service.this.service_url
}

output "dns_records" {
  description = "The DNS values needed to configure a custom domain name"
  value       = local.enable_custom_domain > 0 ? aws_apprunner_custom_domain_association.service["custom_domain"].dns_target : null
}

output "runtime" {
  value = local.apprunner_runtime
}
