module "common_vars" {
  source = "github.com:evoteum/tofu-modules.git//common/vars?ref=main"
}

resource "aws_dynamodb_table" "table" {
  name         = "${var.project_name}-${var.table_name}"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "${var.table_name}_id"

  attribute {
    name = "event_id"
    type = "S"
  }

  attribute {
    name = "user_id"
    type = "S"
  }

  global_secondary_index {
    name            = var.global_secondary_index_name
    hash_key        = var.global_secondary_index_hash_key
    projection_type = "ALL"
    read_capacity   = 0
    write_capacity  = 0
  }

  tags = {
    Name = "${var.project_name}-${var.table_name}"
  }
}

