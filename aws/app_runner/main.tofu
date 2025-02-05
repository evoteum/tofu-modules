module "common" {
  source = "../../common"
}

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
  }

  health_check_configuration {
    path = var.health_check_path
  }
}

# IAM role for App Runner
resource "aws_iam_role" "app_runner" {
  name = "${var.project_name}-${var.environment}-app-runner-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "tasks.apprunner.amazonaws.com"
      }
    }]
  })
}

# ECR policy
resource "aws_iam_policy" "ecr" {
  count = var.enable_ecr ? 1 : 0
  name  = "${var.project_name}-${var.environment}-ecr-policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = [
        "ecr-public:GetAuthorizationToken",
        "ecr-public:BatchCheckLayerAvailability",
        "ecr-public:GetRepositoryPolicy",
        "ecr-public:DescribeRepositories",
        "ecr-public:DescribeImages",
        "ecr-public:GetRepositoryCatalogData"
      ]
      Resource = "*"
    }]
  })
}

# ECR policy attachment
resource "aws_iam_role_policy_attachment" "ecr" {
  count      = var.enable_ecr ? 1 : 0
  role       = aws_iam_role.app_runner.name
  policy_arn = aws_iam_policy.ecr[0].arn
}

# CloudWatch Logs policy
resource "aws_iam_policy" "cloudwatch" {
  name = "${var.project_name}-${var.environment}-cloudwatch-logs-policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ]
      Resource = ["arn:aws:logs:*:*:*"]
    }]
  })
}

# CloudWatch Logs policy attachment
resource "aws_iam_role_policy_attachment" "cloudwatch" {
  role       = aws_iam_role.app_runner.name
  policy_arn = aws_iam_policy.cloudwatch.arn
}
