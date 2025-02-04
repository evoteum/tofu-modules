output "cloudfront_domain_name" {
  description = "The domain name of the CloudFront distribution"
  value       = aws_cloudfront_distribution.app.domain_name
}

output "app_runner_url" {
  description = "The URL of the App Runner service"
  value       = aws_apprunner_service.app.service_url
}