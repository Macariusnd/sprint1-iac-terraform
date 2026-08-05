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

variable "bucket_name" {
  description = "Globally unique S3 bucket name — change the suffix if it conflicts"
  type        = string
  default     = "bridgepoint-docs-npo-7391"
}

variable "noncurrent_transition_days" {
  description = "Days before noncurrent versions move to STANDARD_IA (cheaper storage)"
  type        = number
  default     = 30
}

variable "noncurrent_expiry_days" {
  description = "Days before noncurrent versions are permanently deleted"
  type        = number
  default     = 90
}
