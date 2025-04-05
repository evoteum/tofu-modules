resource "aws_apprunner_service" "service" {
  service_name = "${var.project_name}-${var.environment}-service"

  source_configuration {
    image_repository {
      image_configuration {
        port = var.port
        runtime_environment_variables = merge(
          var.runtime_environment_variables,
          {
            "AWS_REGION" = var.aws_region
          }
        )
      }
      image_identifier      = var.container_image
      image_repository_type = var.enable_ecr ? "ECR" : "ECR_PUBLIC"
    }
    auto_deployments_enabled = true
  }

  instance_configuration {
    cpu               = var.cpu
    memory            = var.memory
    instance_role_arn = aws_iam_role.app_runner.arn
    min_instances     = var.min_instances
    max_instances     = var.max_instances
  }

  health_check_configuration {
    path                = var.health_check_path
    protocol            = "HTTP"
    interval            = var.health_check_interval
    timeout             = var.health_check_timeout
    healthy_threshold   = var.health_check_healthy_threshold
    unhealthy_threshold = var.health_check_unhealthy_threshold
  }

  network_configuration {
    egress_configuration {
      egress_type       = var.vpc_connector_arn != null ? "VPC" : "DEFAULT"
      vpc_connector_arn = var.vpc_connector_arn
    }
  }

  auto_scaling_configuration_arn = aws_apprunner_auto_scaling_configuration_version.main.arn
}

resource "aws_apprunner_auto_scaling_configuration_version" "main" {
  auto_scaling_configuration_name = "${var.project_name}-${var.environment}-scaling"

  max_concurrency = var.max_concurrency
  max_size        = var.max_instances
  min_size        = var.min_instances

  tags = {
    Name        = "${var.project_name}-${var.environment}-scaling"
    Environment = var.environment
  }
}

resource "aws_apprunner_custom_domain_association" "service" {
  for_each    = length(local.base_domain) > 0 ? { custom_domain : local.base_domain } : {}
  service_arn = aws_apprunner_service.service.arn
  domain_name = each.value
}
