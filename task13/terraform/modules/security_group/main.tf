############################################### public security group for ec2 in vpc
resource "aws_security_group" "public_security_group" {
  # link with vpc via id
  vpc_id = var.vpc_id
  name = "public-security-group"
  description = "public internet access"
  tags = {
    Name = "public-security-group"
  }
}
####### rule 1 - all outbound traffic allows
resource "aws_security_group_rule" "public_out_all" {
  type        = "egress" # выход
  from_port   = 0
  to_port     = 0
  protocol    = "all" # or -1
  cidr_blocks = [ var.vpc_cidr ]
  # set this rule to aws_security_group ( public_security_group )
  security_group_id = aws_security_group.public_security_group.id
}
####### rule 2 - for connect bastion host via ssh in public subnet
resource "aws_security_group_rule" "public_in_ssh" {
  type              = "ingress" # вход
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = [ var.vpc_cidr ]
  # set this rule to aws_security_group ( public_security_group )
  security_group_id = aws_security_group.public_security_group.id
}
 
############################################### private security group for rds in vpc
resource "aws_security_group" "private_security_group" {
  # link with vpc via id
  vpc_id = var.vpc_id
  name = "private-security-group"
  description = "private internet access"
  tags = {
    Name = "private-security-group"
  }
}
####### rule 1
resource "aws_security_group_rule" "private_out_all" {
  type        = "egress" # выход
  from_port   = 0
  to_port     = 0
  protocol    = "all" # or -1
  cidr_blocks = [ var.vpc_cidr ] 
  # set this rule to aws_security_group ( private_security_group )
  security_group_id = aws_security_group.private_security_group.id
}
####### rule 2 - for get access rds
resource "aws_security_group_rule" "private_in_for_rds" {
  # 5432 - rds tcp
  type              = "ingress" # вход
  from_port         = 5432
  to_port           = 5432
  protocol          = "tcp" 
  cidr_blocks       = [ var.vpc_cidr ]
  # set this rule to aws_security_group ( private_security_group )
  security_group_id = aws_security_group.private_security_group.id
}