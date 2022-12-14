variable "db_password" {
  default = "rwafdfer"
}
variable "public_subnet_id" {
  # variable sets after vpc/main.tf output
}
variable "security_group_public_id" {
  # variable sets after security_group/main.tf output
}