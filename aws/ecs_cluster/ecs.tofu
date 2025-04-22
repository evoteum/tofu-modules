resource "aws_ecs_cluster" "this" {
  name = "${var.project_name}-${var.environment}-${var.name}"

  setting {
    name  = "containerInsights"
    value = var.enable_container_insights ? "enhanced" : "disabled"
  }
}

resource "aws_ecs_cluster_capacity_providers" "this" {
  cluster_name = aws_ecs_cluster.this.name
  capacity_providers = [
    "FARGATE",
    "FARGATE_SPOT"
  ]
}
