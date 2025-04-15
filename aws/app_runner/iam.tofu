resource "aws_iam_role" "app_runner" {
  name = "${local.resource_prefix}-app-runner-role"

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

resource "aws_iam_policy" "ecr" {
  for_each = {
    for key, val in { enabled = var.enable_ecr } : key => val if val
  }
  name = "${local.resource_prefix}-ecr-policy"

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

resource "aws_iam_role_policy_attachment" "ecr" {
  for_each = {
    for key, val in { enabled = var.enable_ecr } : key => val if val
  }
  role       = aws_iam_role.app_runner.name
  policy_arn = aws_iam_policy.ecr[0].arn
}

resource "aws_iam_policy" "cloudwatch" {
  name = "${local.resource_prefix}-cloudwatch-logs-policy"

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

resource "aws_iam_role_policy_attachment" "cloudwatch" {
  role       = aws_iam_role.app_runner.name
  policy_arn = aws_iam_policy.cloudwatch.arn
}

resource "aws_iam_policy" "dynamodb" {
  for_each = {
    for key, val in { enabled = local.has_dynamodb } : key => val if val
  }
  name   = "${local.resource_prefix}-dynamodb-policy"
  policy = data.aws_iam_policy_document.dynamodb[0].json
}

resource "aws_iam_policy" "rds" {
  for_each = {
    for key, val in { enabled = local.has_rds } : key => val if val
  }
  name   = "${local.resource_prefix}-rds-policy"
  policy = data.aws_iam_policy_document.rds[0].json
}

resource "aws_iam_policy" "elasticache" {
  for_each = {
    for key, val in { enabled = local.has_elasticache } : key => val if val
  }
  name   = "${local.resource_prefix}-elasticache-policy"
  policy = data.aws_iam_policy_document.elasticache[0].json
}

resource "aws_iam_policy" "s3" {
  for_each = {
    for key, val in { enabled = var.enable_ecr } : key => val if val
  }
  name   = "${local.resource_prefix}-s3-policy"
  policy = data.aws_iam_policy_document.s3[0].json
}

resource "aws_iam_policy" "secrets_manager" {
  for_each = {
    for key, val in { enabled = local.has_secrets_manager } : key => val if val
  }
  name   = "${local.resource_prefix}-secrets-manager-policy"
  policy = data.aws_iam_policy_document.secrets_manager[0].json
}

resource "aws_iam_policy" "ssm" {
  for_each = {
    for key, val in { enabled = local.has_ssm } : key => val if val
  }
  name   = "${local.resource_prefix}-ssm-policy"
  policy = data.aws_iam_policy_document.ssm[0].json
}

resource "aws_iam_policy" "sqs" {
  for_each = {
    for key, val in { enabled = local.has_sqs } : key => val if val
  }
  name   = "${local.resource_prefix}-sqs-policy"
  policy = data.aws_iam_policy_document.sqs[0].json
}

resource "aws_iam_policy" "sns" {
  for_each = {
    for key, val in { enabled = local.has_sns } : key => val if val
  }
  name   = "${local.resource_prefix}-sns-policy"
  policy = data.aws_iam_policy_document.sns[0].json
}

resource "aws_iam_policy" "kms" {
  for_each = {
    for key, val in { enabled = local.has_kms } : key => val if val
  }
  name   = "${local.resource_prefix}-kms-policy"
  policy = data.aws_iam_policy_document.kms[0].json
}

resource "aws_iam_role_policy_attachment" "dynamodb" {
  for_each = {
    for key, val in { enabled = local.has_dynamodb } : key => val if val
  }
  role       = aws_iam_role.app_runner.name
  policy_arn = aws_iam_policy.dynamodb[0].arn
}

resource "aws_iam_role_policy_attachment" "rds" {
  for_each = {
    for key, val in { enabled = local.has_rds } : key => val if val
  }
  role       = aws_iam_role.app_runner.name
  policy_arn = aws_iam_policy.rds[0].arn
}

resource "aws_iam_role_policy_attachment" "elasticache" {
  for_each = {
    for key, val in { enabled = local.has_elasticache } : key => val if val
  }
  role       = aws_iam_role.app_runner.name
  policy_arn = aws_iam_policy.elasticache[0].arn
}

resource "aws_iam_role_policy_attachment" "s3" {
  for_each = {
    for key, val in { enabled = local.has_s3 } : key => val if val
  }
  role       = aws_iam_role.app_runner.name
  policy_arn = aws_iam_policy.s3[0].arn
}

resource "aws_iam_role_policy_attachment" "secrets_manager" {
  for_each = {
    for key, val in { enabled = local.has_secrets_manager } : key => val if val
  }
  role       = aws_iam_role.app_runner.name
  policy_arn = aws_iam_policy.secrets_manager[0].arn
}

resource "aws_iam_role_policy_attachment" "ssm" {
  for_each = {
    for key, val in { enabled = local.has_ssm } : key => val if val
  }
  role       = aws_iam_role.app_runner.name
  policy_arn = aws_iam_policy.ssm[0].arn
}

resource "aws_iam_role_policy_attachment" "sqs" {
  for_each = {
    for key, val in { enabled = local.has_sqs } : key => val if val
  }
  role       = aws_iam_role.app_runner.name
  policy_arn = aws_iam_policy.sqs[0].arn
}

resource "aws_iam_role_policy_attachment" "sns" {
  for_each = {
    for key, val in { enabled = local.has_sns } : key => val if val
  }
  role       = aws_iam_role.app_runner.name
  policy_arn = aws_iam_policy.sns[0].arn
}

resource "aws_iam_role_policy_attachment" "kms" {
  for_each = {
    for key, val in { enabled = local.has_kms } : key => val if val
  }
  role       = aws_iam_role.app_runner.name
  policy_arn = aws_iam_policy.kms[0].arn
}
