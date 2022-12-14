resource "aws_db_subnet_group" "test" {
  name       = "test"
  subnet_ids = [ var.public_subnet_id ]

  tags = {
    Name = "db-subnet-group"
  }
}


resource "aws_db_parameter_group" "test" {
  name   = "test"
  family = "postgres14"

  parameter {
    name  = "log_connections"
    value = "1"
  }
}

resource "aws_db_instance" "testpostgresql" {
  identifier             = "testpostgresql"
  instance_class         = "db.t3.micro"
  allocated_storage      = 5
  engine                 = "postgres"
  engine_version         = "14.1"
  username               = "postgres"
  password               = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.test.name
  vpc_security_group_ids = [ var.security_group_public_id ]
  parameter_group_name   = aws_db_parameter_group.test.name
  publicly_accessible    = true
  skip_final_snapshot    = true
  multi_az               = true
}
