resource "aws_apprunner_service" "this" {
  service_name = "${local.resource_prefix}-service"

  health_check_configuration {
    path                = var.health_check_path
    protocol            = "HTTP"
    interval            = var.health_check_interval
    timeout             = var.health_check_timeout
    healthy_threshold   = var.health_check_healthy_threshold
    unhealthy_threshold = var.health_check_unhealthy_threshold
  }

  source_configuration {
    auto_deployments_enabled = var.auto_deployments_enabled

    dynamic "authentication_configuration" {
      for_each = {
        for key, val in { enabled = local.is_code_source } : key => val if val
      }
      content {
        connection_arn = var.aws_apprunner_connection_arn
      }
    }

    dynamic "code_repository" {
      for_each = local.is_code_source ? { enabled = true } : {}
      content {
        repository_url   = var.github_repository
        source_directory = var.source_directory
        source_code_version {
          type  = "BRANCH"
          value = var.source_branch
        }
        code_configuration {
          configuration_source = "API"
          code_configuration_values {
            runtime                       = local.apprunner_runtime
            build_command                 = var.build_command
            start_command                 = var.start_command
            port                          = var.port
            runtime_environment_secrets   = var.runtime_environment_secrets
            runtime_environment_variables = var.runtime_environment_variables
          }
        }
      }
    }

    dynamic "image_repository" {
      for_each = local.is_container_source ? { enabled = true } : {}
      content {
        image_identifier      = var.ecr_repository
        image_repository_type = "ECR_PUBLIC"
        image_configuration {
          port                          = var.port
          runtime_environment_secrets   = var.runtime_environment_secrets
          runtime_environment_variables = var.runtime_environment_variables
        }
      }
    }
  }

  instance_configuration {
    cpu               = var.cpu
    memory            = var.memory
    instance_role_arn = aws_iam_role.app_runner.arn
  }

  network_configuration {
    ingress_configuration {
      is_publicly_accessible = var.is_publicly_accessible
    }
    dynamic "egress_configuration" {
      for_each = var.vpc_connector_arn != "" ? { enabled = true } : {}
      content {
        egress_type       = "VPC"
        vpc_connector_arn = var.vpc_connector_arn
      }
    }

    dynamic "egress_configuration" {
      for_each = var.vpc_connector_arn == "" ? { enabled = true } : {}
      content {
        egress_type = "DEFAULT"
      }
    }

  }
}

resource "aws_apprunner_custom_domain_association" "service" {
  for_each    = local.enable_custom_domain ? { custom_domain = var.custom_domain } : {}
  service_arn = aws_apprunner_service.this.arn
  domain_name = local.custom_domain_parsed.host
}
