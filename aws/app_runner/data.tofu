data "aws_iam_policy_document" "dynamodb" {
  for_each = local.enable_dynamodb ? { enabled = true } : {}

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
    resources = var.dynamodb_arns
  }
}
