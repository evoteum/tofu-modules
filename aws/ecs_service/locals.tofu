locals {
  resource_prefix = "${var.project_id}-${var.environment}"
  environment_variables = {
    for k, v in merge(
      var.environment_variables,
      {
        DYNAMODB_TABLE = var.dynamodb_table_name,
        AWS_REGION     = var.aws_region,
      }
    ) : k => v if v != null && v != ""
  }
}
