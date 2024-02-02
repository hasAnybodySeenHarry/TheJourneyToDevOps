resource "aws_security_group" "ecs_app_lb_sg" {
  name   = "${var.cluster_name}-app-lb-sg"
  vpc_id = aws_vpc.vpc.id

  ingress {
    from_port   = local.https_port
    to_port     = local.https_port
    cidr_blocks = [local.all_ips]
    protocol    = local.tcp_protocol
  }

  ingress {
    from_port   = local.http_port
    to_port     = local.http_port
    cidr_blocks = [local.all_ips]
    protocol    = local.tcp_protocol
  }

  egress {
    from_port   = local.any_port
    to_port     = local.any_port
    cidr_blocks = [local.all_ips]
    protocol    = local.any_protocol
  }
}

resource "aws_lb" "ecs_app_lb" {
  name               = "${var.cluster_name}-app-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.ecs_app_lb_sg.id]
  subnets            = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id, aws_subnet.public_subnet_3.id]
}

resource "aws_lb_target_group" "ecs_target_group" {
  name        = "${var.cluster_name}-target-group"
  target_type = "ip"

  port     = 3000
  protocol = local.http_protocol
  vpc_id   = aws_vpc.vpc.id

  health_check {
    path     = "/api/v1/"
    protocol = local.http_protocol
  }
}

resource "aws_lb_listener" "ecs_app_lb_listener" {
  load_balancer_arn = aws_lb.ecs_app_lb.arn
  port              = local.http_port
  protocol          = local.http_protocol

  default_action {
    target_group_arn = aws_lb_target_group.ecs_target_group.arn
    type             = "forward"
  }
}
