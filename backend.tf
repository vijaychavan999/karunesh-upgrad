# Create S3 bucket
resource "aws_s3_bucket" "terraform_backend" {
  bucket = "kst-terraform-backend-bucket-30042023000000"
  acl    = "private"

  tags = {
    Name = "Terraform Backend Bucket"
  }

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

# Create S3 backend configuration for Terraform
terraform {
  backend "s3" {
    bucket = "kst-terraform-backend-bucket-30042023000000"
    key    = "terraform/state.tfstate"
    region = "us-east-1"
  }
}