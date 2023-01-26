# EC2 WITH APACHE2
resource "aws_instance" "web" {
# Ubuntu 18.04 LTS AMI
  ami = "ami-0d500797138456fbb"
  instance_type = "t2.micro"
  subnet_id = var.public_subnet_id
  security_groups = [aws_security_group.web.id]
  depends_on = [aws_security_group.web]
  user_data = <<EOF
#!/bin/bash

apt-get update
apt-get install -y apache2

service apache2 start
EOF
  tags = {
    Name = "web_instance"
  }
}

# Create a security group for web
resource "aws_security_group" "web" {
  name   = "web"
  vpc_id = var.vpc_id

  #Allow incoming Ping
  ingress {
      from_port   = -1
      to_port     = -1
      protocol    = "icmp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  # Allow incoming traffic on port 22 (SSH)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # Allow incoming traffic on port 80 (HTTP)
    ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # Allow outgoing traffic on all port
    egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}
