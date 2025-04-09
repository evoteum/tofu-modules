locals {
  table_name = "${var.project_name}-${var.environment}-${var.table_name}"
}

resource "aws_dynamodb_table" "this" {
  name         = local.table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "${var.table_name}_key"

  tags = {
    Name = local.table_name
  }
}

