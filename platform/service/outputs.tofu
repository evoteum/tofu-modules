output "listener_rule_arn" {
  value = module.aws_load_balancer_domain_binding.listener_rule_arn
}

output "service_arn" {
  value = module.aws_ecs_service.service_arn
}

output "service_environment_variables" {
  value = module.aws_ecs_service.environment_variables
}
