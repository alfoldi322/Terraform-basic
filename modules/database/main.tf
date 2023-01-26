# EC2 WITH PSQL
resource "aws_instance" "database" {
# Ubuntu 18.04 LTS AMI
  ami = "ami-0d500797138456fbb"
  instance_type = "t2.micro"
  subnet_id = var.private_subnet_id
  security_groups = [aws_security_group.database.id]
  private_ip = "10.0.2.5"
  user_data = <<EOF
#!/bin/bash

apt-get update
apt-get install -y postgresql

service postgresql start
EOF
  tags = {
    Name = "database_instance"
  }
}

# Create a security group for database
resource "aws_security_group" "database" {
  name   = "database"
  vpc_id = var.vpc_id
  
   # Allow incoming ping from Java-sg
  ingress {
      from_port   = -1
      to_port     = -1
      protocol    = "icmp"
      cidr_blocks = ["0.0.0.0/0"]
      security_groups = [var.java_sg_id]
  }
  # Allow incoming traffic on port 22 (SSH)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # Allow incoming traffic on port 5432 (PSQL) from Java-sg
    ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    security_groups = [var.java_sg_id]
  }
  # Allow outgoing traffic on all port
    egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
    tags = {
    Name = "database_sg"
  }
}