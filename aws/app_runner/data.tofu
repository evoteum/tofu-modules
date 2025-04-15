data "aws_iam_policy_document" "dynamodb" {
  for_each = anytrue([
    for arn in var.service_arns.databases : contains(arn, "dynamodb")
  ]) ? { enabled = true } : {}

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
