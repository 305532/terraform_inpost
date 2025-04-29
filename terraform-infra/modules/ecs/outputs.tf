output "cluster_id" {
  value = aws_ecs_cluster.this.id
}

output "service_name" {
  value = aws_ecs_service.this.name
}

output "alb_dns_name" {
  value = aws_lb.alb.dns_name
}
output "task_sg_id" {
  description = "Security group ID for ECS tasks"
  value       = aws_security_group.task_sg.id
}