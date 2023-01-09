# Cloud provider

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}
provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}

# Import modules

# VPC + SUBNETS + ROUTING
module "network" {
  source = "./modules/network"
}
# Database EC2 + DB security group
module "database" {
  source = "./modules/database"
}
# Java EC2 + Java security group
module "java" {
  source = "./modules/java"
}
# Web EC2 + Web security group
module "web" {
  source = "./modules/web"
}
