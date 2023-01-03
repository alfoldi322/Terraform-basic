# Create two subnets

#Public
resource "aws_subnet" "alfoldi322-public" {
  vpc_id            = aws_vpc.alfoldi322.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "{var.region}a"
  route_table_id  = aws_route_table.alfoldi322public.id
  map_public_ip_on_launch = true

  tags = {
    Name = "alfoldi322-subnet-a"
  }
}

#Private
resource "aws_subnet" "alfoldi322-private" {
  vpc_id            = aws_vpc.alfoldi322private.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "{var.region}b"
  route_table_id  = aws_route_table.alfoldi322.id
  map_public_ip_on_launch = false

  tags = {
    Name = "alfoldi322-subnet-private"
  }
}

# Create an Elastic IP for the NAT gateway
resource "aws_eip" "alfoldi322" {
  vpc = true
}

# Create the NAT + IP
resource "aws_nat_gateway" "alfoldi322" {
  allocation_id = aws_eip.alfoldi322.id
  subnet_id     = aws_subnet.alfoldi322-public.id
  route_table_id  = aws_route_table.alfoldi322public.id
}

resource "aws_internet_gateway" "example" {
  vpc_id = aws_vpc.alfoldi322.id
}

# Create route for private-subnet > NAT
resource "aws_route" "private-to-nat" {
  route_table_id         = aws_route_table.alfoldi322-private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.alfoldi322.id
}

# Create a route public-subnet > IGW
resource "aws_route" "public-to-igw" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.example.id
}