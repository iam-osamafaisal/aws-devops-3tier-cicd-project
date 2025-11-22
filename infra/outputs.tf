##############################
# VPC Outputs
##############################

output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnets" {
  value = aws_subnet.public[*].id
}

output "private_subnets" {
  value = aws_subnet.private[*].id
}

##############################
# ALB Outputs
##############################

output "alb_dns_name" {
  value = aws_lb.app_alb.dns_name
  description = "Public DNS of the Application Load Balancer"
}

output "alb_arn" {
  value = aws_lb.app_alb.arn
}

##############################
# ECS Outputs
##############################

output "ecs_cluster_name" {
  value = aws_ecs_cluster.app_cluster.name
}

output "ecs_service_name" {
  value = aws_ecs_service.app_service.name
}

output "ecs_task_definition" {
  value = aws_ecs_task_definition.app_task.arn
}

##############################
# RDS Outputs
##############################

output "db_endpoint" {
  value       = aws_db_instance.db_instance.address
  description = "RDS MySQL Endpoint (Use in App Tier env variables)"
}

output "db_port" {
  value = aws_db_instance.db_instance.port
}

##############################
# Project Info
##############################

output "project_name" {
  value = var.project
}

output "image_version_deployed" {
  value = var.image_tag
  description = "Docker image tag currently deployed via CI/CD"
}
