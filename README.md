This repository contains Terraform code and GitHub Actions workflows to:

- **Bootstrap** a remote state backend (S3 + DynamoDB)  
- **Deploy** core AWS infrastructure (VPC, ECS, RDS, S3)  
- **Enforce** CI checks (terraform fmt/validate, tflint, tfsec, Checkov)

## Repository structure
1. `.github/workflows` - contains CI/CD pipelines
2. `terraform-backend` - contains terraform code to setup terraform backend for the main infrastructure
3. `terraform-infra` - contains terraform code for the main infrastructure