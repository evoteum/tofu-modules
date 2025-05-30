locals {
  requires_compatibilities = [var.launch_type == "FARGATE" ? "FARGATE" : "EC2"]
}

resource "aws_ecs_task_definition" "this" {
  family                   = local.resource_prefix
  cpu                      = var.cpu
  memory                   = var.memory
  network_mode             = var.network_mode
  requires_compatibilities = local.requires_compatibilities
  execution_role_arn       = aws_iam_role.execution_role.arn
  task_role_arn            = aws_iam_role.task_role.arn

  container_definitions = jsonencode([
    {
      name      = var.project_name
      image     = var.container_image
      essential = true
      portMappings = [
        {
          containerPort = var.container_port
          protocol      = "tcp"
        }
      ]
      environment = [
        for k, v in local.environment_variables : {
          name  = k
          value = v
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = aws_cloudwatch_log_group.this.name
          awslogs-region        = var.aws_region
          awslogs-stream-prefix = var.project_name
        }
      }
    }
  ])

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_ecs_service" "this" {
  name            = local.resource_prefix
  cluster         = var.cluster_arn
  task_definition = aws_ecs_task_definition.this.arn
  launch_type     = var.launch_type
  desired_count   = var.desired_count

  network_configuration {
    subnets = var.subnet_ids
    security_groups = compact(flatten([
      aws_security_group.ecs_service.id,
      var.service_security_group_ids,
    ]))
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = var.project_name
    container_port   = var.container_port
  }

  depends_on = [
    aws_ecs_task_definition.this,
  ]
}
