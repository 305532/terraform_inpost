terraform {
  backend "s3" {
    bucket         = "state_bucket_name"
    key            = "global/${var.environment}/terraform.tfstate"
    region         = var.aws_region
    dynamodb_table = "locking_table_name"
    encrypt        = true
  }
}