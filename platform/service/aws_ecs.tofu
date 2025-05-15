locals {
  container_image_latest = "${module.quay_repository.path}:latest"
}

module "aws_ecs_service" {
  source = "github.com/evoteum/tofu-modules//aws/ecs_service"

  aws_region            = var.aws_region
  cluster_arn           = var.cluster_arn
  container_image       = local.container_image_latest
  container_port        = var.container_port
  cpu                   = var.cpu
  desired_count         = var.desired_count
  dynamodb_table_arn    = module.aws_dynamodb.table_arn
  environment           = var.environment
  health_check_path     = var.health_check_path
  launch_type           = var.launch_type
  lb_security_group_id  = var.lb_security_group_id
  log_retention_in_days = var.log_retention_in_days
  memory                = var.memory
  network_mode          = var.network_mode
  project_id            = var.repository_id
  project_name          = var.repository_name
  subnet_ids            = var.subnet_ids
  vpc_id                = var.vpc_id
}
