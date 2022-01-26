#Define Provider & Backend

provider "aws" {
  region = var.region
}

terraform {
  required_version = ">= 0.13.0"
}


#terraform {
#  backend "s3" {
#    bucket  = "tf-state"
#    region  = "us-east-1"
#  }
#}
