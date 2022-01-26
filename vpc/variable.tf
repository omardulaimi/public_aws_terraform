#############################
# Region
#############################

variable "region" {
  description = "AWS region"
  default     = "us-gov-east-1"
}

#############################
# VPC
#############################

variable "custom_vpc" {
  description = "VPC Configuration"
  default = {
    vpc_cidr_block       = "10.10.0.0/20"
    vpc_instance_tenancy = "default"
    vpc_dnsSupport       = true
    vpc_dnsHostNames     = true
    vpc_name             = "App-name"
    #vpc_department       = "Dev"
    vpc_environment = "Production"
  }
}

#############################
# Subnets
#############################

variable "public_subnets_config" {
  description = "VPC - Public Subnets"
  default = {
    "Public-Subnet-1a" = {
      public_subnet_cidr = "10.10.11.0/24"
      public_subnet_az   = "us-gov-east-1a"
      publicIPMapping    = "true"
      name               = "App-name-public-1a"
      tier               = "Public"
    },
    "Public-Subnet-1b" = {
      public_subnet_cidr = "10.10.12.0/24"
      public_subnet_az   = "us-gov-east-1b"
      publicIPMapping    = "true"
      name               = "App-name-public-1b"
      tier               = "Public"
    },
  }
}


variable "private_subnets_config" {
  description = "VPC - Private Subnets"
  default = {
    "Private-Subnet-1c" = {
      private_subnet_cidr = "10.10.13.0/24"
      private_subnet_az   = "us-gov-east-1a"
      publicIPMapping     = "false"
      name                = "App-name-private-1c"
      tier                = "Private"
    },
    "Private-Subnet-1d" = {
      private_subnet_cidr = "10.10.14.0/24"
      private_subnet_az   = "us-gov-east-1b"
      publicIPMapping     = "false"
      name                = "App-name-private-1d"
      tier                = "Private"
    },
  }
}

#############################
# NAT Gateway
#############################

variable "nat_gw_ip" {
  description = "subnet_nat_ip_config"
  default = {
    nat_gw_ip_name = "App-name NAT-Gateway-IP"
  }
}

variable "vpc_nat_gw_config" {
  description = "vpc_nat_gateway"
  default = {
    nat_gw_name = "App-name Private Subnets NAT"
  }
}

#############################
# Route Tables
#############################
variable "public_route_config" {
  description = "Public Route Table"
  default = {
    cidr_block        = "0.0.0.0/0"
    public_route_name = "App-name Public Route Tables"
  }
}

variable "private_route_config" {
  description = "Private Route Table"
  default = {
    cidr_block         = "0.0.0.0/0"
    private_route_name = "App-name Private Route Tables"
  }
}

