output "state_bucket_name" {
  description = "Name of the S3 bucket storing Terraform state"
  value       = aws_s3_bucket.tf_state.id
}

output "state_bucket_arn" {
  description = "ARN of the state bucket"
  value       = aws_s3_bucket.tf_state.arn
}

output "dynamodb_table_name" {
  description = "Name of the DynamoDB lock table"
  value       = aws_dynamodb_table.tf_locks.name
}

output "dynamodb_table_arn" {
  description = "ARN of the DynamoDB lock table"
  value       = aws_dynamodb_table.tf_locks.arn
}

output "backend_config" {
  description = "Copy this backend block into your sprint1-vpc-remote/providers.tf"
  value       = <<-BACKEND
    backend "s3" {
      bucket         = "${aws_s3_bucket.tf_state.id}"
      key            = "sprint1/vpc/terraform.tfstate"
      region         = "${aws_s3_bucket.tf_state.region}"
      dynamodb_table = "${aws_dynamodb_table.tf_locks.name}"
      encrypt        = true
    }
  BACKEND
}
