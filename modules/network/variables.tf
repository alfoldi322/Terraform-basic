# VPC
variable "vpc" {
  default = "main_vpc"
}
variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
}
# Public subnet
variable "public_subnet" {
  default = "public_subnet"
}
# Public subnet CIDR
variable "public_cidr_block" {
  default = "10.0.12.0/22"
}
# Route table
variable "public_route_table" {
  default = "public_route_table"
}
# Private subnet
variable "private_subnet" {
  default = "private_subnet"
}
# Private subnet CIDR
variable "private_cidr_block" {
  default = "10.0.2.0/24"
}
# Route table
variable "private_route_table" {
  default = "private_route_table"
}
# Internet gateway
variable "internet_gw" {
  default = "internet_gateway"
}
# Nat gateway
variable "nat_gw" {
  default = "nat_gateway"
}
# Elastic ip
variable "elastic_ip" {
  default = "elastic_ip"
}