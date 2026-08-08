variable "aws_region" {
  description = "AWS region to deploy into"
  type        = string
  default     = "eu-west-1"
}

variable "environment" {
  description = "Deployment environment label"
  type        = string
  default     = "dev"
}

variable "state_bucket_name" {
  description = "Globally unique name for the Terraform state S3 bucket"
  type        = string
  default     = "bridgepoint-tf-state-npo-7391"
}

variable "lock_table_name" {
  description = "DynamoDB table name for Terraform state locking"
  type        = string
  default     = "bridgepoint-tf-locks"
}
