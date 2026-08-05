output "bucket_name" {
  description = "Name of the S3 bucket"
  value       = aws_s3_bucket.bridgepoint_docs.id
}

output "bucket_arn" {
  description = "ARN of the S3 bucket"
  value       = aws_s3_bucket.bridgepoint_docs.arn
}

output "bucket_region" {
  description = "AWS region the bucket lives in"
  value       = aws_s3_bucket.bridgepoint_docs.region
}

output "bucket_domain_name" {
  description = "Domain name of the bucket (for programmatic access)"
  value       = aws_s3_bucket.bridgepoint_docs.bucket_domain_name
}

output "versioning_status" {
  description = "Versioning status of the bucket"
  value       = aws_s3_bucket_versioning.bridgepoint_docs.versioning_configuration[0].status
}

output "uploaded_object_key" {
  description = "Key (path) of the test object uploaded to the bucket"
  value       = aws_s3_object.readme.key
}

output "console_url" {
  description = "Direct link to view the bucket in AWS Console"
  value       = "https://s3.console.aws.amazon.com/s3/buckets/${aws_s3_bucket.bridgepoint_docs.id}"
}
