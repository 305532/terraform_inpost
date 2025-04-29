output "alb_dns_name" {
  description = "DNS name of the HTTPS ALB"
  value       = module.ecs.alb_dns_name
}

output "ecs_cluster_id" {
  description = "ECS Cluster ID"
  value       = module.ecs.cluster_id
}

output "ecs_service_name" {
  description = "ECS Service"
  value       = module.ecs.service_name
}

output "rds_endpoint" {
  description = "RDS endpoint"
  value       = module.rds.endpoint
}

output "s3_bucket" {
  description = "S3 bucket name"
  value       = module.s3.bucket
}
