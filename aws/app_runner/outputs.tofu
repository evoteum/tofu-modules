output "url" {
  description = "The URL of the App Runner service"
  value       = aws_apprunner_service.service.service_url
}

output "dns_records" {
  description = "The DNS values needed to configure a custom domain name"
  value       = length(local.base_domain) > 0 ? aws_apprunner_custom_domain_association.service.dns_target["custom_domain"] : null
}