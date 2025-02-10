

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

resource "aws_iam_policy" "dynamodb" {
  count  = local.has_dynamodb ? 1 : 0
  name   = "${var.project_name}-${var.environment}-dynamodb-policy"
  policy = data.aws_iam_policy_document.dynamodb[0].json
}

resource "aws_iam_policy" "rds" {
  count  = local.has_rds ? 1 : 0
  name   = "${var.project_name}-${var.environment}-rds-policy"
  policy = data.aws_iam_policy_document.rds[0].json
}

resource "aws_iam_policy" "elasticache" {
  count  = local.has_elasticache ? 1 : 0
  name   = "${var.project_name}-${var.environment}-elasticache-policy"
  policy = data.aws_iam_policy_document.elasticache[0].json
}

resource "aws_iam_policy" "s3" {
  count  = local.has_s3 ? 1 : 0
  name   = "${var.project_name}-${var.environment}-s3-policy"
  policy = data.aws_iam_policy_document.s3[0].json
}

resource "aws_iam_policy" "secrets_manager" {
  count  = local.has_secrets_manager ? 1 : 0
  name   = "${var.project_name}-${var.environment}-secrets-manager-policy"
  policy = data.aws_iam_policy_document.secrets_manager[0].json
}

resource "aws_iam_policy" "ssm" {
  count  = local.has_ssm ? 1 : 0
  name   = "${var.project_name}-${var.environment}-ssm-policy"
  policy = data.aws_iam_policy_document.ssm[0].json
}

resource "aws_iam_policy" "sqs" {
  count  = local.has_sqs ? 1 : 0
  name   = "${var.project_name}-${var.environment}-sqs-policy"
  policy = data.aws_iam_policy_document.sqs[0].json
}

resource "aws_iam_policy" "sns" {
  count  = local.has_sns ? 1 : 0
  name   = "${var.project_name}-${var.environment}-sns-policy"
  policy = data.aws_iam_policy_document.sns[0].json
}

resource "aws_iam_policy" "kms" {
  count  = local.has_kms ? 1 : 0
  name   = "${var.project_name}-${var.environment}-kms-policy"
  policy = data.aws_iam_policy_document.kms[0].json
}

resource "aws_iam_role_policy_attachment" "dynamodb" {
  count      = local.has_dynamodb ? 1 : 0
  role       = aws_iam_role.app_runner.name
  policy_arn = aws_iam_policy.dynamodb[0].arn
}

resource "aws_iam_role_policy_attachment" "rds" {
  count      = local.has_rds ? 1 : 0
  role       = aws_iam_role.app_runner.name
  policy_arn = aws_iam_policy.rds[0].arn
}

resource "aws_iam_role_policy_attachment" "elasticache" {
  count      = local.has_elasticache ? 1 : 0
  role       = aws_iam_role.app_runner.name
  policy_arn = aws_iam_policy.elasticache[0].arn
}

resource "aws_iam_role_policy_attachment" "s3" {
  count      = local.has_s3 ? 1 : 0
  role       = aws_iam_role.app_runner.name
  policy_arn = aws_iam_policy.s3[0].arn
}

resource "aws_iam_role_policy_attachment" "secrets_manager" {
  count      = local.has_secrets_manager ? 1 : 0
  role       = aws_iam_role.app_runner.name
  policy_arn = aws_iam_policy.secrets_manager[0].arn
}

resource "aws_iam_role_policy_attachment" "ssm" {
  count      = local.has_ssm ? 1 : 0
  role       = aws_iam_role.app_runner.name
  policy_arn = aws_iam_policy.ssm[0].arn
}

resource "aws_iam_role_policy_attachment" "sqs" {
  count      = local.has_sqs ? 1 : 0
  role       = aws_iam_role.app_runner.name
  policy_arn = aws_iam_policy.sqs[0].arn
}

resource "aws_iam_role_policy_attachment" "sns" {
  count      = local.has_sns ? 1 : 0
  role       = aws_iam_role.app_runner.name
  policy_arn = aws_iam_policy.sns[0].arn
}

resource "aws_iam_role_policy_attachment" "kms" {
  count      = local.has_kms ? 1 : 0
  role       = aws_iam_role.app_runner.name
  policy_arn = aws_iam_policy.kms[0].arn
}
