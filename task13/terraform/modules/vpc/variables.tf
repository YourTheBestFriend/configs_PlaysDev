############################################## variables 
variable "env" {
    default = "Dev"
}
variable "base_cidr_block" {
  default = "10.0.0.0/16"
}
variable "aws_region" {
    default = "us-east-1"
}

############################################### for multi az
variable "availability_zones" {
  default = [ "us-east-1a", "us-east-1b" ] # type = list(string)
}

############################################### public and private subnet + db subnet
variable "public_subnet_cidrs" {
  default = [ "10.0.1.0/24", "10.0.2.0/24" ]
}
variable "private_subnet_cidrs" {
  default = [ "10.0.11.0/24", "10.0.12.0/24" ]
}
variable "private_subnet_db_cidrs" {
  default = [ "10.0.21.0/24", "10.0.22.0/24" ]
}