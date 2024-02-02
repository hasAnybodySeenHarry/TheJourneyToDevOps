output "ecs_alb_hostname" {
  description = "The hostname of the ECS Application Load Balancer"
  value       = aws_lb.ecs_app_lb.dns_name
}
