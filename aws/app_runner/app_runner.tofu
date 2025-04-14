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
      for_each = local.is_code_source ? { code_source : local.is_code_source } : {}
      content {
        connection_arn = var.aws_apprunner_connection_arn
      }
    }

    dynamic "code_repository" {
      for_each = local.is_code_source ? { code_source : local.is_code_source } : {}
      content {
        repository_url = var.application_source_uri
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
      for_each = local.is_container_source ? { image_source : local.is_container_source } : {}
      content {
        image_identifier      = var.application_source_uri
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
      for_each = local.is_custom_vpc ? [1] : []
      content {
        egress_type       = "VPC"
        vpc_connector_arn = var.vpc_connector_arn
      }
    }

    dynamic "egress_configuration" {
      for_each = local.is_custom_vpc ? [] : [1]
      content {
        egress_type = "DEFAULT"
      }
    }

  }
}

resource "aws_apprunner_custom_domain_association" "service" {
  for_each    = length(local.base_domain) > 0 ? { custom_domain : local.base_domain } : {}
  service_arn = aws_apprunner_service.this.arn
  domain_name = each.value
}
