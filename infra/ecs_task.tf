############################################
# ECS Cluster
############################################

resource "aws_ecs_cluster" "app_cluster" {
  name = "${var.project}-cluster"
}

############################################
# IAM Roles for ECS Task Execution
############################################

data "aws_iam_policy_document" "ecs_task_assume" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ecs_task_execution_role" {
  name               = "${var.project}-task-execution-role"
  assume_role_policy = data.aws_iam_policy_document.ecs_task_assume.json
}

resource "aws_iam_role_policy_attachment" "ecs_execution_attach" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

############################################
# ECS Task Definition (Fargate)
############################################

resource "aws_ecs_task_definition" "app_task" {
  family                   = "${var.project}-app-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"

  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([
    {
      name      = "node-app"
      image     = "your-dockerhub-user/node-app:${var.image_tag}"
      essential = true
      portMappings = [
        {
          containerPort = 3000
          protocol      = "tcp"
        }
      ]
      environment = [
        { name = "DB_HOST", value = aws_db_instance.db_instance.address },
        { name = "DB_USER", value = var.db_username },
        { name = "DB_PASSWORD", value = var.db_password },
        { name = "DB_NAME", value = var.db_name }
      ],
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = "/ecs/${var.project}"
          awslogs-region        = var.aws_region
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])
}

############################################
# Create Log Group for ECS
############################################

resource "aws_cloudwatch_log_group" "ecs_log_group" {
  name              = "/ecs/${var.project}"
  retention_in_days = 7
}

############################################
# ECS Service for App Tier
############################################

resource "aws_ecs_service" "app_service" {
  name            = "${var.project}-service"
  cluster         = aws_ecs_cluster.app_cluster.id
  launch_type     = "FARGATE"
  task_definition = aws_ecs_task_definition.app_task.arn
  desired_count   = 2

  network_configuration {
    subnets         = aws_subnet.private[*].id
    security_groups = [aws_security_group.ecs_sg.id]
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.app_tg.arn
    container_name    = "node-app"
    container_port    = 3000
  }

  depends_on = [
    aws_lb_listener.http_listener
  ]
}
