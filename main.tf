# Cloud provider
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}
# Import modules

# VPC + SUBNETS + ROUTING
module "network" {
  source = "./modules/network"
}
# Database EC2 + DB security group
module "database" {
  source = "./modules/database"
  depends_on = [module.java]
}
# Java EC2 + Java security group
module "java" {
  source = "./modules/java"
  depends_on = [module.network]
}
# Web EC2 + Web security group
module "web" {
  source = "./modules/web"
  depends_on = [module.network]
}
