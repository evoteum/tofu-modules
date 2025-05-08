module "aws_dynamodb" {
  source = "github.com/evoteum/tofu-modules//aws/dynamodb"

  project_name = var.repository_name
  project_id   = var.repository_id
  environment  = var.environment

  table_name               = var.dynamodb.table_name
  billing_mode             = var.dynamodb.billing_mode
  hash_key                 = var.dynamodb.hash_key
  range_key                = var.dynamodb.range_key
  attributes               = var.dynamodb.attributes
  global_secondary_indexes = var.dynamodb.global_secondary_indexes
}
