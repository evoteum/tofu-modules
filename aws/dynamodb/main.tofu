locals {
  table_name = lower("${var.project_name}-${var.environment}-${var.table_name}")
}

resource "aws_dynamodb_table" "this" {
  name         = local.table_name
  billing_mode = var.billing_mode
  hash_key     = var.hash_key
  range_key    = var.range_key

  dynamic "attribute" {
    for_each = var.attributes
    content {
      name = attribute.key
      type = upper(attribute.value)
    }
  }

  dynamic "global_secondary_index" {
    for_each = var.global_secondary_indexes
    content {
      name            = global_secondary_index.key
      hash_key        = global_secondary_index.value.hash_key
      range_key       = global_secondary_index.value.range_key
      projection_type = global_secondary_index.value.projection_type
    }
  }

  tags = {
    Name = local.table_name
  }

  lifecycle {
    prevent_destroy = false
  }
}


resource "aws_dynamodb_table_export" "this" {
  for_each = var.backup_bucket != "" ? { enabled : true } : {}

  table_arn     = aws_dynamodb_table.this.arn
  s3_bucket     = var.backup_bucket
  s3_prefix     = "${local.table_name}/${formatdate("YYYY-MM-DDThh-mm-ssZZZ", timestamp())}"
  export_format = "DYNAMODB_JSON"
}
