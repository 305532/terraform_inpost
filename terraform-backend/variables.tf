variable "aws_region" {
  description = "AWS region to create backend resources in"
  type        = string
  default     = "eu-central-1"
}

variable "bucket_name" {
  description = "Name of the S3 bucket to store Terraform state"
  type        = string
  default     = "state_bucket_name"
}

variable "dynamodb_table_name" {
  description = "Name of the DynamoDB table for Terraform state locking"
  type        = string
  default     = "locking_table_name"
}