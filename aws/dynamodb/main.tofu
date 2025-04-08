locals {
  table_name = "${var.project_name}-${var.environment}-${var.table_name}"
}

resource "aws_dynamodb_table" "table" {
  name         = local.table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "${var.table_name}_id"

  dynamic "attribute" {
    for_each = var.attributes
    content {
      name = attribute.value.name
      type = attribute.value.type
    }
  }


  tags = {
    Name = local.table_name
  }
}

