output "vpc_id" {
  value = aws_vpc.main_vpc.id
  depends_on = [aws_vpc.main_vpc]
}
output "public_subnet_id" {
  value = aws_subnet.public_subnet.id
  depends_on = [aws_subnet.public_subnet]
}
output "private_subnet_id" {
  value = aws_subnet.private_subnet.id
  depends_on = [aws_subnet.private_subnet]
}
output "igw_id" {
  value = aws_internet_gateway.internet_gateway.id
  depends_on = [aws_subnet.private_subnet]
}
output "nat_id" {
  value = aws_nat_gateway.nat_gateway.id
  depends_on = [aws_subnet.private_subnet]
}
output "public_route_table_id" {
  value = aws_route_table.public_route_table.id
  depends_on = [aws_route_table.public_route_table]
}
output "private_route_table_id" {
  value = aws_route_table.private_route_table.id
  depends_on = [aws_route_table.private_route_table]
}
output "elastic_ip_id" {
  value = aws_eip.elastic_ip.id
  depends_on = [aws_eip.elastic_ip]
}

