variable "vpc_id" {
    # dynamic via output vpc
}
# variable "vpc_cidr" {
#     # defautl vpc_cidr for ruels in security group (in main.tf) 
# }

variable "vpc_cidr_all" {
  default = "0.0.0.0/0" 
}