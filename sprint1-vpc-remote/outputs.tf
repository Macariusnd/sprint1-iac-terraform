output "vpc_id" {
  description = "ID of the VPC (state stored remotely in S3)"
  value       = aws_vpc.main.id
}

output "vpc_cidr" {
  description = "CIDR block of the VPC"
  value       = aws_vpc.main.cidr_block
}

output "public_subnet_ids" {
  description = "IDs of the public subnets"
  value       = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "IDs of the private subnets"
  value       = aws_subnet.private[*].id
}

output "state_location" {
  description = "Where Terraform state is stored"
  value       = "s3://bridgepoint-tf-state-npo-7391/sprint1/vpc/terraform.tfstate"
}
