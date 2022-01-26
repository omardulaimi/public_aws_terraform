#############################
# Region
#############################

variable "region" {
  description = "AWS region"
  default     = "us-east-1"
}

#############################
# RDS
#############################

variable "postgres_rds" {
  default = {
    identifier = "app-name"
    name       = "app-name"

    allocated_storage = "20"
    storage_type      = "gp2"
    storage_encrypted = true

    engine         = "postgres"
    engine_version = "12.3"

    port           = "5432"
    instance_class = "db.t3.small"

    publicly_accessible = false
    multi_az            = false

    backup_retention_period = "35"
    skip_final_snapshot     = true
  }
}

#############################
# VPC
#############################

variable "vpc_id" {
  description = "VPC ID Config"
  default = {
    vpc_id  = "vpc-xxxxxxxx"
    vpcname = "app-name-vpc"
  }
}

variable "subnets_ids" {
  type    = list
  default = ["subnet-xxxxxx", "subnet-xxxxxxx"]
}

variable "SecurityGroups_ids" {
  type    = list
  default = ["sg-xxxxxxxx"]
}

#############################
# RDS Secret
#############################

variable "rds_secret" {
  description = "RDS Secret Name"
  default = {
    secretid = "app-name"
  }
}
