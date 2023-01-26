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
# Database EC2 + DB security group -- Import VPC,Subent,Java-sg
module "database" {
  source = "./modules/database"
  depends_on = [module.java]
  vpc_id = module.network.vpc_id
  private_subnet_id = module.network.private_subnet_id
  java_sg_id = module.java.java_sg_id
}
# Java EC2 + Java security group -- Import VPC,Subnet,Web-sg
module "java" {
  source = "./modules/java"
  vpc_id = module.network.vpc_id
  public_subnet_id = module.network.public_subnet_id
  web_sg_id = module.web.web_sg_id
  depends_on = [module.web]
}
# Web EC2 + Web security group -- Import VPC,Subnet
module "web" {
  source = "./modules/web"
  vpc_id = module.network.vpc_id
  public_subnet_id = module.network.public_subnet_id
  depends_on = [module.network]
}
