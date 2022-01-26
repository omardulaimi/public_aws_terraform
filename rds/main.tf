# rds.tf 
# rds & SG

#############################
# RDS
#############################

resource "aws_db_instance" "postgres_rds" {
  identifier = var.postgres_rds.identifier
  name       = var.postgres_rds.name

  allocated_storage = var.postgres_rds.allocated_storage
  storage_type      = var.postgres_rds.storage_type
  storage_encrypted = var.postgres_rds.storage_encrypted

  engine         = var.postgres_rds.engine
  engine_version = var.postgres_rds.engine_version

  port           = var.postgres_rds.port
  instance_class = var.postgres_rds.instance_class

  publicly_accessible = var.postgres_rds.publicly_accessible
  multi_az            = var.postgres_rds.multi_az

  backup_retention_period = var.postgres_rds.backup_retention_period
  skip_final_snapshot     = var.postgres_rds.skip_final_snapshot


  db_subnet_group_name   = aws_db_subnet_group.rds_subnetgroup.id
  vpc_security_group_ids = var.SecurityGroups_ids

  username = local.db_creds.username
  password = local.db_creds.password

}


#############################
# RDS Subnet Group
#############################

resource "aws_db_subnet_group" "rds_subnetgroup" {
  name       = var.postgres_rds.name
  subnet_ids = var.subnets_ids
  tags = {
    Name = var.vpc_id.vpcname
  }
}

#############################
# RDS Secret
#############################

data "aws_secretsmanager_secret_version" "rds_secret" {
  secret_id = var.rds_secret.secretid
}

locals {
  db_creds = jsondecode(
    data.aws_secretsmanager_secret_version.rds_secret.secret_string
  )
}
