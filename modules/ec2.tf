# 3 EC2 Ubuntu 18.04 LTS | 1 PSQL | 1 APACHE2 | 1 JRE:11 |


# EC2 WITH PSQL
resource "aws_instance" "database" {
# Ubuntu 18.04 LTS AMI
  ami = "ami-0f55e09c5540d9b2f"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.alfoldi322-private
  security_groups = [aws_security_group.alfoldi322-db.sg-db322]
  user_data = <<EOF
#!/bin/bash

apt-get update
apt-get install -y postgresql

service postgresql start
EOF
}

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