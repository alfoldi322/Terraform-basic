# EC2 WITH PSQL
resource "aws_instance" "database" {
# Ubuntu 18.04 LTS AMI
  ami = "ami-0f55e09c5540d9b2f"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.alfoldi322-private
  security_groups = [aws_security_group.alfoldi322-db.sg-db322]
  private_ip = "10.0.0.5"
  user_data = <<EOF
#!/bin/bash

apt-get update
apt-get install -y postgresql

service postgresql start
EOF
}

# Create a security group for database
resource "aws_security_group" "alfoldi322-db" {
  name   = "alfoldi322-db"
  security_group_id = "sg-db322"
  vpc_id = aws_vpc.alfoldi322.id

  # Allow nicoming Ping from Java
  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = "sg-java322"
  }
  # Allow incoming traffic on port 22 (SSH)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # Allow incoming traffic on port 5432 (PSQL)
    ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = "sg-java322"
  }
  # Allow outgoing traffic on all port
    egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}