resource "aws_ecs_cluster" "ecs_cluster" {
  name = "${var.cluster_name}-cluster"
}

resource "aws_ecs_task_definition" "tools_task" {
  container_definitions = jsonencode(
    [
      {
        name      = "tools"
        image     = "harry2an/tools:latest"
        cpu       = 128
        memory    = 256
        essential = true
        portMappings = [
          {
            containerPort = 3000
          }
        ],
        environment = [
          {
            name  = "DB_ENDPOINT"
            value = aws_db_instance.app_db.endpoint
          },
          {
            name  = "DB_USERNAME"
            value = var.db_username
          },
          {
            name  = "DB_PASSWORD"
            value = var.db_password
          },
          {
            name  = "DB_NAME"
            value = aws_db_instance.app_db.db_name
          },
        ]
      },
    ]
  )

  family                   = "tools-family"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 128
  memory                   = 256
  network_mode             = "awsvpc"
  task_role_arn            = "arn:aws:iam::accountid:role/ecsTaskExecutionRole"
  execution_role_arn       = "arn:aws:iam::accountid:role/ecsTaskExecutionRole"
}

resource "aws_security_group" "app_sg" {
  name   = "ecs-app-sg"
  vpc_id = aws_vpc.vpc.id

  ingress {
    from_port        = 3000
    to_port          = 3000
    security_groups  = [aws_security_group.ecs_app_lb_sg.id]
    protocol         = local.tcp_protocol
  }

  egress {
    from_port   = local.any_port
    to_port     = local.any_port
    cidr_blocks = [local.all_ips]
    protocol    = local.any_protocol
  }
}

resource "aws_ecs_service" "ecs_service" {
  name                   = var.service_name
  cluster                = aws_ecs_cluster.ecs_cluster.arn
  launch_type            = "FARGATE"
  enable_execute_command = true

  deployment_maximum_percent         = 200
  deployment_minimum_healthy_percent = 100
  desired_count                      = 1
  task_definition                    = aws_ecs_task_definition. tools_task.arn

  network_configuration {
    assign_public_ip = true
    security_groups  = [aws_security_group.app_sg.id]
    subnets          = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id, aws_subnet.public_subnet_3.id]
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.ecs_target_group.arn
    container_name   = "tools"
    container_port   = 3000
  }
}
