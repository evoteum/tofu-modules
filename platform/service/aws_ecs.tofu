locals {
  container_image_latest = "${module.quay_repository.path}:latest"
  environment_variables = merge(
    var.environment_variables,
    {
    AWS_REGION     = var.aws_region,
    DYNAMODB_TABLE = module.aws_dynamodb.table_name,
    }
  )
}

module "aws_ecs_service" {
  source = "github.com/evoteum/tofu-modules//aws/ecs_service"

  cluster_arn           = var.cluster_arn
  container_image       = local.container_image_latest
  container_port        = var.container_port
  cpu                   = var.cpu
  desired_count         = var.desired_count
  dynamodb_table_arn    = module.aws_dynamodb.table_arn
  environment           = var.environment
  environment_variables = local.environment_variables
  health_check_path     = var.health_check_path
  launch_type           = var.launch_type
  log_retention_in_days = var.log_retention_in_days
  memory                = var.memory
  network_mode          = var.network_mode
  project_id            = var.repository_id
  project_name          = var.repository_name
  region                = var.region
  security_group_id     = var.lb_security_group_id
  subnet_ids            = var.subnet_ids
  vpc_id                = var.vpc_id
}
