resource "aws_cloudwatch_log_group" "this" {
  name              = "/ecs/${local.resource_prefix}"
  retention_in_days = var.log_retention_in_days
}