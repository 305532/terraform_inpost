variable "aws_region" {
  description = "AWS region to deploy into"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Deployment environment (dev, prod, etc.)"
  type        = string
  default     = "dev"
}

variable "certificate_arn" {
  description = "ARN of the ACM certificate for HTTPS on the ALB"
  type        = string
}

variable "web_image" {
  description = "Container image to run (WebGoat)"
  type        = string
  default     = "webgoat/webgoat-8.0.0"
}

variable "ecs_desired_count" {
  description = "Number of ECS tasks to run"
  type        = number
  default     = 2
}

variable "ecs_task_cpu" {
  description = "CPU units for ECS task"
  type        = string
  default     = "256"
}

variable "ecs_task_memory" {
  description = "Memory (MiB) for ECS task"
  type        = string
  default     = "512"
}

variable "container_port" {
  description = "Port WebGoat listens on inside the container"
  type        = number
  default     = 8080
}

variable "db_username" {
  description = "RDS master username"
  type        = string
  default     = "admin"
}

variable "db_name" {
  description = "Name of the application database"
  type        = string
  default     = "appdb"
}

variable "rds_instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.t3.micro"
}

variable "bucket_name" {
  description = "S3 bucket for application assets"
  type        = string
  default     = "application_bucket"
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for the public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  description = "List of CIDR blocks for the private subnets"
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24"]
}
