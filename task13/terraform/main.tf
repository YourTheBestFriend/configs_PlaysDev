terraform {
    required_providers {
        aws = {
            source  = "hashicorp/aws"
        }
    }
}

provider "aws" {
  region = "us-east-1"
}

module "vpc" {
    source = "./modules/vpc"
}

output "vpc_module" {  
  value = module.vpc 
}

module "security_group" {
    source   = "./modules/security_group"
    vpc_id   = module.vpc.vpc_id
    #vpc_cidr =  module.vpc.vpc_cidr # in security_group/variables.rf - set cidr "0.0.0.0/0"
}

output "security_group_module" {  
  value = module.security_group
}

module "ec2" {
  source            = "./modules/ec2"
  # which subnet
  public_subnet_id  = module.vpc.public_subnet_ids[0]
  private_subnet_id = module.vpc.private_subnet_ids[0]
  # security group
  sg_id             = module.security_group.security_group_public # accecc for instance in subnets and ssh connection
}

output "ec2_module" {  
  value = module.ec2
}

module "rds" {
  source                   = "./modules/rds"
  # set subnet
  public_subnet_id         = module.vpc.public_subnet_ids[0]
  # security group - for access via tcp 5432 to rds
  security_group_public_id = module.security_group.security_group_rds
}

output "rds_module" {  
  value     = module.rds
  sensitive = true
}