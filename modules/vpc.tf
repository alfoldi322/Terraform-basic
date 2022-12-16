# Create a VPC
resource "aws_vpc" "alfoldi322" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "alfoldi322-vpc"
  }
}
