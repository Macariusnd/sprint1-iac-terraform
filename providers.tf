terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region

  # No credentials here — use `aws configure` or environment variables:
  # export AWS_ACCESS_KEY_ID="your-key-id"
  # export AWS_SECRET_ACCESS_KEY="your-secret-key"

  default_tags {
    tags = {
      Project     = "BridgePoint"
      ManagedBy   = "Terraform"
      Environment = var.environment
      Owner       = "Nnamdi-okereke"
    }
  }
}
