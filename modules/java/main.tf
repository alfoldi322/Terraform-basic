# Import network module
module "network" {
  source = "../network"
}

# EC2 WITH JRE11
resource "aws_instance" "java" {
  ami = "ami-0f55e09c5540d9b2f"
  instance_type = "t2.micro"
  subnet_id = var.public_subnet_id
  security_groups = [aws_security_group.java.id]
  user_data = <<EOF
#!/bin/bash

apt-get update
apt-get install -y openjdk-11-jdk
EOF
}

# Create a security group for java

resource "aws_security_group" "java" {
  name   = "java"
  vpc_id = var.vpc_id
  depends_on = [module.network.vpc]

 # Allow incoming Ping
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
    from_port   = 8080
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
