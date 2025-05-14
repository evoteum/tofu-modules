resource "aws_security_group" "ecs_service" {
  name        = "${local.resource_prefix}-sg"
  description = "Security group for ECS service ${var.project_name}"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${local.resource_prefix}-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "from_alb" {
  security_group_id            = aws_security_group.ecs_service.id
  description                  = "Allow traffic from ALB to container port"
  from_port                    = var.container_port
  to_port                      = var.container_port
  ip_protocol                  = "tcp"
  referenced_security_group_id = var.security_group_id
}

resource "aws_vpc_security_group_egress_rule" "allow_all" {
  security_group_id = aws_security_group.ecs_service.id
  description       = "Allow all outbound traffic"
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
}