######################################## info
output "vpc_id" {
  value = aws_vpc.main.id
}
output "vpc_cidr" {
  value = aws_vpc.main.cidr_block
}
######################################### need info for set ec2 and rds to subnet via subnet's id
output "public_subnet_ids" {
  value = aws_subnet.public_subnets[*].id
}
output "private_subnet_ids" {
  value = aws_subnet.private_subnets[*].id
}
output "private_db_subnet_ids" {
  value = aws_subnet.private_db_subnets[*].id
}