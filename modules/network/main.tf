# Create VPC
resource "aws_vpc" "main_vpc" {
  cidr_block = "${var.vpc_cidr_block}"

  tags = {
    Name = "main_vpc"
  }
}

# Create data for AZ
data "aws_availability_zones" "available" {
  state = "available"
}

# Create two subnets

# Public
resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = "${var.public_cidr_block}"
  availability_zone = "${data.aws_availability_zones.available.names[0]}"
  map_public_ip_on_launch = true

  tags = {
    Name = "public_subnet"
  }
}

# Private
resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = "${var.private_cidr_block}"
  availability_zone = "${data.aws_availability_zones.available.names[0]}"
  map_public_ip_on_launch = false
  tags = {
    Name = "private_subnet"
  }
}

# Create an Elastic IP for the NAT gateway
resource "aws_eip" "elastic_ip" {
  vpc        = true
}

# Create the NAT + IP
resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.elastic_ip.id
  subnet_id     = aws_subnet.public_subnet.id
}

# Create an IGW
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id     = aws_vpc.main_vpc.id
}

# Create route table for private subnet
resource "aws_route_table" "private_route_table" {
  vpc_id     = aws_vpc.main_vpc.id
}

# Create route for private-subnet > NAT
resource "aws_route" "private_to_nat" {
  route_table_id         = aws_route_table.private_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gateway.id
}

# Create route table for public subnet
resource "aws_route_table" "public_route_table" {
  vpc_id      = aws_vpc.main_vpc.id
}

# Public subnet route table association
resource "aws_route_table_association" "public_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}


# Create a route public-subnet > IGW
resource "aws_route" "public-to-internet" {
  route_table_id         = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.internet_gateway.id
}