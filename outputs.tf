output "vpc_id" {
  description = "ID of the BridgePoint VPC"
  value       = aws_vpc.main.id
}

output "vpc_cidr" {
  description = "CIDR block of the VPC"
  value       = aws_vpc.main.cidr_block
}

output "internet_gateway_id" {
  description = "ID of the Internet Gateway"
  value       = aws_internet_gateway.main.id
}

output "public_subnet_ids" {
  description = "IDs of the two public subnets"
  value       = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "IDs of the two private subnets"
  value       = aws_subnet.private[*].id
}

output "public_route_table_id" {
  description = "ID of the public route table"
  value       = aws_route_table.public.id
}

output "private_route_table_id" {
  description = "ID of the private route table"
  value       = aws_route_table.private.id
}

output "instance_id" {
  description = "ID of the EC2 web server instance"
  value       = aws_instance.web_server.id
}

output "instance_public_ip" {
  description = "Public IP address of the web server"
  value       = aws_instance.web_server.public_ip
}

output "ssh_command" {
  description = "Ready-to-run SSH command to connect to the instance"
  value       = "ssh -i bridgepoint-key.pem ec2-user@${aws_instance.web_server.public_ip}"
}

output "http_url" {
  description = "URL to test the web server in a browser"
  value       = "http://${aws_instance.web_server.public_ip}"
}

output "security_group_id" {
  description = "ID of the BridgePoint security group"
  value       = aws_security_group.bridgepoint_sg.id
}
