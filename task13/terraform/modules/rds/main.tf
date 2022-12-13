resource "aws_rds_cluster" "rds_cluster" {
  cluster_identifier = "testclusterrds"
  engine             = "postgres"
  engine_mode        = "provisioned"
  engine_version     = "13.6"
  database_name      = "my_postgresql_db"
  master_username    = "postgres"
  master_password    = var.db_password

  serverlessv2_scaling_configuration {
    max_capacity = 1.0
    min_capacity = 0.5
  }
}

resource "aws_rds_cluster_instance" "rds_cluster_instance" {
  cluster_identifier = aws_rds_cluster.rds_cluster.id
  instance_class     = "db.t3.micro"
  engine             = aws_rds_cluster.rds_cluster.engine
  engine_version     = aws_rds_cluster.rds_cluster.engine_version
}