output "app_runner_url" {
  description = "The URL of the App Runner service"
  value       = aws_apprunner_service.app.service_url
}