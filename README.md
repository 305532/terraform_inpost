This repository contains Terraform code and GitHub Actions workflows to:

- **Bootstrap** a remote state backend (S3 + DynamoDB)  
- **Deploy** core AWS infrastructure (VPC, ECS, RDS, S3)  
- **Enforce** CI checks (terraform fmt/validate, tflint, tfsec, Checkov)  
- **Provide** local pre-commit hooks for formatting and security scans

## Repository structure
1. `.github/workflows` - contains CI/CD pipelines
2. `terraform-backend` - contains terraform code to setup terraform backend for the main infrastructure
3. `terraform-infra` - contains terraform code for the main infrastructure


## Local Pre-commit Setup

1. Install Python 3 + pip  
2. `pip install pre-commit`
3. `python3 -m pre_commit autoupdate`
4. `python3 -m pre_commit install`  
5. On each commit, the following will run automatically:
   - `terraform fmt -check`
   - `terraform validate`
   - `tflint`
   - `checkov --quiet`
6. To test against all files:  
   `python3 -m pre_commit run --all-files`


