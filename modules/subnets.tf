# Create two subnets

#Public
resource "aws_subnet" "alfoldi322-public" {
  vpc_id            = aws_vpc.alfoldi322.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "{var.region}a"
  map_public_ip_on_launch = true

  tags = {
    Name = "alfoldi322-subnet-a"
  }
}

#Private
resource "aws_subnet" "alfoldi322-private" {
  vpc_id            = aws_vpc.alfoldi322.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "{var.region}b"
  map_public_ip_on_launch = false

  tags = {
    Name = "alfoldi322-subnet-private"
  }
}