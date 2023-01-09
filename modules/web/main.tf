# EC2 WITH APACHE2
resource "aws_instance" "web" {
# Ubuntu 18.04 LTS AMI
  ami = "ami-0f55e09c5540d9b2f"
  instance_type = "t2.micro"
  subnet_id =  aws_subnet.alfoldi322-public
  security_groups = [aws_security_group.alfoldi322-web.sg-web322]
  user_data = <<EOF
#!/bin/bash

apt-get update
apt-get install -y apache2

service apache2 start
EOF
}

# Create a security group for web
resource "aws_security_group" "alfoldi322-web" {
  name   = "alfoldi322-web"
  security_group_id = "sg-web322"
  vpc_id = aws_vpc.alfoldi322.id

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
