data "aws_availability_zones" "available" {}

module "vpc" {
  source               = "./modules/vpc"
  cidr_block           = var.vpc_cidr_block
  azs                  = slice(data.aws_availability_zones.available.names, 0, length(var.public_subnet_cidrs))
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
}

module "s3" {
  source      = "./modules/s3"
  environment            = var.environment
  bucket_name = var.bucket_name
}

module "rds" {
  source                     = "./modules/rds"
  vpc_id                     = module.vpc.vpc_id
  subnet_ids                 = module.vpc.private_subnets
  username                   = var.db_username
  db_name                    = var.db_name
  instance_class             = var.rds_instance_class
  allowed_security_group_ids = [module.ecs.task_sg_id]
}

module "ecs" {
  source                 = "./modules/ecs"
  aws_region             = var.aws_region
  vpc_id                 = module.vpc.vpc_id
  public_subnets         = module.vpc.public_subnets
  private_subnets        = module.vpc.private_subnets
  certificate_arn        = var.certificate_arn
  image                  = var.web_image
  environment            = var.environment
  desired_count          = var.ecs_desired_count
  task_cpu               = var.ecs_task_cpu
  task_memory            = var.ecs_task_memory
  container_port         = var.container_port
  db_host                = module.rds.endpoint
  db_port                = module.rds.port
  db_name                = var.db_name
  db_user                = var.db_username
  db_password_secret_arn = module.rds.db_secret_arn
}
