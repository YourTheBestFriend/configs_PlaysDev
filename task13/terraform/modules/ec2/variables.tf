variable "ami" {
  default = "ami-0574da719dca65348"
}
variable "instance_type" {
    default = "t2.nano"
}
# key for get ssh access
variable "key_name" {
    default = "linux-key-pair"
}

variable "sg_id" {
  # variable set via output complete in (security_group/main.tf) (main.tf - where all modules)
}
variable "public_subnet_id" {
  # variable set via output complete in (vpc/main.tf) (main.tf - where all modules)
}
variable "private_subnet_id" {
  # variable set via output complete in (vpc/main.tf) (main.tf - where all modules)
}