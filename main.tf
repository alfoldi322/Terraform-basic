# CLOUD PROVIDER

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

#IMPORT MODULES

module "vpc" {
  source = "./modules/vpc"
}
module "security-groups" {
  source = "./modules/security-groups"
}
module "subnets" {
  source = "./modules/subnets"
}
module "ec2" {
  source = "./modules/ec2"
  vpc_id = module.vpc.vpc_id
}
module "variables" {
  source = "./modules/variables"
}