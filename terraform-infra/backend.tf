terraform {
  backend "s3" {
    bucket         = "state_bucket_name"
    key            = "global/dev/terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "locking_table_name"
    encrypt        = true
  }
}