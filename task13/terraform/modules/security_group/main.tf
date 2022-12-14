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
  cidr_blocks = [ var.vpc_cidr_all ]
  # set this rule to aws_security_group ( public_security_group )
  security_group_id = aws_security_group.public_security_group.id
}
####### rule 2 - for connect bastion host via ssh in public subnet
resource "aws_security_group_rule" "public_in_ssh" {
  type              = "ingress" # вход
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = [ var.vpc_cidr_all ]
  # set this rule to aws_security_group ( public_security_group )
  security_group_id = aws_security_group.public_security_group.id
}

############################################### Security Group for public rds
resource "aws_security_group" "security_group_rds" {
  vpc_id = var.vpc_id
  name = "security-group"
  description = "rds access"
  tags = {
    Name = "security-group-rds"
  }
}
####### rule 1 - for rds out
resource "aws_security_group_rule" "public_out_tcp_rds" {
  type        = "egress" # выход
  from_port   = 5432
  to_port     = 5432
  protocol    = "tcp" # or -1
  cidr_blocks = [ var.vpc_cidr_all ]
  # set this rule to aws_security_group ( public_security_group )
  security_group_id = aws_security_group.security_group_rds.id
}
####### rule 2 - for rds in
resource "aws_security_group_rule" "public_in_tcp_rds" {
  type              = "ingress" # вход
  from_port         = 5432
  to_port           = 5432
  protocol          = "tcp"
  cidr_blocks       = [ var.vpc_cidr_all ]
  # set this rule to aws_security_group ( public_security_group )
  security_group_id = aws_security_group.security_group_rds.id
}