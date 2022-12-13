# output for check ID my groups 
output "security_group_public" {
  value = aws_security_group.public_security_group.id
}
output "security_group_private" {
  value = aws_security_group.private_security_group.id
}