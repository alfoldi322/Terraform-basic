# EC2 WITH JRE11
resource "aws_instance" "java" {
  ami = "ami-0f55e09c5540d9b2f"
  instance_type = "t2.micro"
  subnet_id =  aws_subnet.alfoldi322-public
  security_groups = [aws_security_group.alfoldi322-web.sg-java322]
  user_data = <<EOF
#!/bin/bash

apt-get update
apt-get install -y openjdk-11-jdk
EOF
}

# Create a security group for java

resource "aws_security_group" "alfoldi322-java" {
  name   = "alfoldi322-java"
  security_group_id = "sg-java322"
  vpc_id = aws_vpc.alfoldi322.id

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
