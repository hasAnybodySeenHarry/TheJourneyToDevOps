resource "aws_security_group" "rds_sg" {
  name        = "rds-sg"
  description = "Security group to control RDS MySQL access in the specified VPC."
  vpc_id      = aws_vpc.vpc.id
}

resource "aws_security_group_rule" "mysql_inbound" {
  security_group_id        = aws_security_group.rds_sg.id
  type                     = "ingress"
  from_port                = local.mysql_port
  to_port                  = local.mysql_port
  protocol                 = local.tcp_protocol
  source_security_group_id = aws_security_group.app_sg.id
}

resource "aws_security_group_rule" "all_outbound" {
  security_group_id = aws_security_group.rds_sg.id
  type              = "egress"
  from_port         = local.any_port
  to_port           = local.any_port
  cidr_blocks       = [local.all_ips]
  protocol          = local.any_protocol
}

resource "aws_db_subnet_group" "db_subnet_group" {
  name = "rds-subnet-group"
  subnet_ids = [
    aws_subnet.private_subnet_1.id,
    aws_subnet.private_subnet_2.id,
    aws_subnet.private_subnet_3.id
  ]
}

resource "aws_db_instance" "app_db" {
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "8.0.35"
  instance_class         = "db.t3.micro"
  username               = var.db_username
  password               = var.db_password
  parameter_group_name   = "default.mysql8.0"
  identifier_prefix      = var.cluster_name
  skip_final_snapshot    = true
  publicly_accessible    = false
  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group.id
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  db_name                = var.service_name
}

