resource "aws_instance" "server_Bastion" {
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = var.key_name
  # which subnet to set
  subnet_id              =  var.public_subnet_id
  # set sg via output after main.tf in folder security_group
  vpc_security_group_ids = [ var.sg_id ]
  tags = {
    Name = "Bastion-Host"
  }
}
resource "aws_instance" "server_private_ec2" {
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = var.key_name
  # which subnet to set
  subnet_id              =  var.private_subnet_id
  # set sg via output after main.tf in folder security_group
  vpc_security_group_ids = [ var.sg_id ]
  tags = {
    Name = "Private-Host"
  }
}