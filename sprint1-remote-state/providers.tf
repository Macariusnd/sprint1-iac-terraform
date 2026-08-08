terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # NO backend block here — this folder uses local state intentionally.
  # You cannot use a remote backend to store the state of the resources
  # that CREATE that remote backend. Bootstrap first, then point at it.
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
