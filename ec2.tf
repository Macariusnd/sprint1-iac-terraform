# ─────────────────────────────────────────────
# Key Pair
# Upload the PUBLIC key to AWS — private key
# stays on your machine and never touches Git
# ─────────────────────────────────────────────
resource "aws_key_pair" "bridgepoint_key" {
  key_name   = "bridgepoint-key"
  public_key = file("${path.module}/bridgepoint-key.pub")

  tags = {
    Name = "bridgepoint-key"
  }
}

# ─────────────────────────────────────────────
# Data source: latest Amazon Linux 2 AMI
# Automatically picks the right AMI for your
# region — no hardcoding AMI IDs
# ─────────────────────────────────────────────
data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# ─────────────────────────────────────────────
# EC2 Instance
# Placed in public subnet so it gets a public IP
# ─────────────────────────────────────────────
resource "aws_instance" "web_server" {
  ami                         = data.aws_ami.amazon_linux_2.id
  instance_type               = "t3.micro"
  subnet_id                   = aws_subnet.public[0].id
  vpc_security_group_ids      = [aws_security_group.bridgepoint_sg.id]
  key_name                    = aws_key_pair.bridgepoint_key.key_name
  associate_public_ip_address = true

  # Bootstrap script: installs and starts a basic web server on launch
  user_data = <<-EOF
    #!/bin/bash
    yum update -y
    yum install -y httpd
    systemctl start httpd
    systemctl enable httpd
    echo "<h1>BridgePoint Web Server — provisioned by Terraform</h1>" > /var/www/html/index.html
  EOF

  tags = {
    Name = "bridgepoint-web-server"
  }
}
