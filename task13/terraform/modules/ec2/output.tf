# server_Bastion
output "instance_public_ip_addr_server_Bastion" {
  value = aws_instance.server_Bastion.public_ip
}
output "instance_private_ip_addr_server_Bastion" {
  value = aws_instance.server_Bastion.private_ip
}
# server_private_ec2
output "instance_public_ip_addr_server_private_ec2" {
  value = aws_instance.server_private_ec2.public_ip
}
output "instance_private_ip_addr_server_private_ec2" {
  value = aws_instance.server_private_ec2.private_ip
}