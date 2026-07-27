resource "aws_security_group" "bridgepoint_sg" {
  name        = "bridgepoint-sg"
  description = "Allow SSH and HTTP inbound traffic for BridgePoint web server"
  vpc_id      = aws_vpc.main.id

  # Inbound: SSH — allows you to log into the server
  ingress {
    description = "SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Inbound: HTTP — allows web browser traffic
  ingress {
    description = "HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound: allow all — instance can reach the internet for updates etc.
  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "bridgepoint-sg"
  }
}
