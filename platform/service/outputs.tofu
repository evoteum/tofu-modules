output "listener_rule_arn" {
  value = module.aws_load_balancer_domain_binding.listener_rule_arn
}

output "service_arn" {
  value = module.aws_ecs_service.service_arn
}
