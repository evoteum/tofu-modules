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
  for_each = local.enable_ecr ? { enabled = true } : {}

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
      Resource = var.ecr_arns
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ecr" {
  for_each = local.enable_ecr ? { enabled = true } : {}

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
  for_each = local.enable_dynamodb ? { enabled = true } : {}

  name   = "${local.resource_prefix}-dynamodb-policy"
  policy = data.aws_iam_policy_document.dynamodb[0].json
}


resource "aws_iam_role_policy_attachment" "dynamodb" {
  for_each = local.enable_dynamodb ? { enabled = true } : {}

  role       = aws_iam_role.app_runner.name
  policy_arn = aws_iam_policy.dynamodb[0].arn
}