data "aws_iam_policy_document" "dynamodb" {
  count = local.has_dynamodb ? 1 : 0

  statement {
    effect = "Allow"
    actions = [
      "dynamodb:GetItem",
      "dynamodb:PutItem",
      "dynamodb:UpdateItem",
      "dynamodb:DeleteItem",
      "dynamodb:Query",
      "dynamodb:Scan",
      "dynamodb:BatchGetItem",
      "dynamodb:BatchWriteItem"
    ]
    resources = local.dynamodb_arns
  }
}

data "aws_iam_policy_document" "rds" {
  count = local.has_rds ? 1 : 0

  statement {
    effect = "Allow"
    actions = [
      "rds-db:connect"
    ]
    resources = local.rds_arns
  }
}

data "aws_iam_policy_document" "elasticache" {
  count = local.has_elasticache ? 1 : 0

  statement {
    effect = "Allow"
    actions = [
      "elasticache:Connect"
    ]
    resources = local.elasticache_arns
  }
}

data "aws_iam_policy_document" "s3" {
  count = local.has_s3 ? 1 : 0

  statement {
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject",
      "s3:ListBucket"
    ]
    resources = concat(local.s3_arns, [for arn in local.s3_arns : "${arn}/*"])
  }
}

data "aws_iam_policy_document" "secrets_manager" {
  count = local.has_secrets_manager ? 1 : 0

  statement {
    effect = "Allow"
    actions = [
      "secretsmanager:GetSecretValue"
    ]
    resources = local.secrets_manager_arns
  }
}

data "aws_iam_policy_document" "ssm" {
  count = local.has_ssm ? 1 : 0

  statement {
    effect = "Allow"
    actions = [
      "ssm:GetParameter",
      "ssm:GetParameters"
    ]
    resources = local.ssm_arns
  }
}

data "aws_iam_policy_document" "sqs" {
  count = local.has_sqs ? 1 : 0

  statement {
    effect = "Allow"
    actions = [
      "sqs:SendMessage",
      "sqs:ReceiveMessage",
      "sqs:DeleteMessage",
      "sqs:GetQueueAttributes"
    ]
    resources = local.sqs_arns
  }
}

data "aws_iam_policy_document" "sns" {
  count = local.has_sns ? 1 : 0

  statement {
    effect = "Allow"
    actions = [
      "sns:Publish"
    ]
    resources = local.sns_arns
  }
}

data "aws_iam_policy_document" "kms" {
  count = local.has_kms ? 1 : 0

  statement {
    effect = "Allow"
    actions = [
      "kms:Decrypt",
      "kms:GenerateDataKey"
    ]
    resources = local.kms_arns
  }
}
