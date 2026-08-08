terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # ─────────────────────────────────────────────
  # REMOTE BACKEND
  # State file now lives in S3, not on your machine.
  # DynamoDB handles locking so no two applies
  # can run at the same time.
  #
  # Fill in the bucket name from Phase 1 outputs.
  # ─────────────────────────────────────────────
  backend "s3" {
    bucket       = "bridgepoint-tf-state-npo-7391"
    key          = "sprint1/vpc/terraform.tfstate"
    region       = "eu-west-1"
    use_lockfile = true
    encrypt      = true
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = "BridgePoint"
      ManagedBy   = "Terraform"
      Environment = var.environment
      Owner       = "mac-okereke"
    }
  }
}
