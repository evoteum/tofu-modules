data "aws_iam_policy_document" "dynamodb" {
  for_each = local.has_dynamodb ? [1] : []

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
  for_each = local.has_rds ? [1] : []

  statement {
    effect = "Allow"
    actions = [
      "rds-db:connect"
    ]
    resources = local.rds_arns
  }
}

data "aws_iam_policy_document" "elasticache" {
  for_each = local.has_elasticache ? [1] : []

  statement {
    effect = "Allow"
    actions = [
      "elasticache:Connect"
    ]
    resources = local.elasticache_arns
  }
}

data "aws_iam_policy_document" "s3" {
  for_each = local.has_s3 ? [1] : []

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
  for_each = local.has_secrets_manager ? [1] : []

  statement {
    effect = "Allow"
    actions = [
      "secretsmanager:GetSecretValue"
    ]
    resources = local.secrets_manager_arns
  }
}

data "aws_iam_policy_document" "ssm" {
  for_each = local.has_ssm ? [1] : []

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
  for_each = local.has_sqs ? [1] : []

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
  for_each = local.has_sns ? [1] : []

  statement {
    effect = "Allow"
    actions = [
      "sns:Publish"
    ]
    resources = local.sns_arns
  }
}

data "aws_iam_policy_document" "kms" {
  for_each = local.has_kms ? [1] : []

  statement {
    effect = "Allow"
    actions = [
      "kms:Decrypt",
      "kms:GenerateDataKey"
    ]
    resources = local.kms_arns
  }
}
