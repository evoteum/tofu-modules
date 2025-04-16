locals {
  table_name    = lower("${var.project_name}-${var.environment}-${var.table_name}")
  hash_key_name = "${var.table_name}-key"
}

resource "aws_dynamodb_table" "this" {
  name         = local.table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = local.hash_key_name

  attribute {
    name = local.hash_key_name
    type = "S"
  }

  tags = {
    Name = local.table_name
  }

  lifecycle {
    prevent_destroy = false
  }
}

