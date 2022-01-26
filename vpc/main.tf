# vpc.tf
# VPC & Subnet Creation

#############################
# VPC
#############################

resource "aws_vpc" "custom_vpc" {
  cidr_block           = var.custom_vpc.vpc_cidr_block
  instance_tenancy     = var.custom_vpc.vpc_instance_tenancy
  enable_dns_support   = var.custom_vpc.vpc_dnsSupport
  enable_dns_hostnames = var.custom_vpc.vpc_dnsHostNames

  tags = {
    Name = var.custom_vpc.vpc_name
    #Department  = var.custom_vpc.vpc_department
    Environment = var.custom_vpc.vpc_environment
  }
}

#############################
# VPC Subnets
#############################

resource "aws_subnet" "public_subnets" {
  for_each                = var.public_subnets_config
  vpc_id                  = aws_vpc.custom_vpc.id
  cidr_block              = each.value.public_subnet_cidr
  availability_zone       = each.value.public_subnet_az
  map_public_ip_on_launch = each.value.publicIPMapping

  tags = {
    Name = each.value.name
  }
}

resource "aws_subnet" "private_subnets" {
  for_each                = var.private_subnets_config
  vpc_id                  = aws_vpc.custom_vpc.id
  cidr_block              = each.value.private_subnet_cidr
  availability_zone       = each.value.private_subnet_az
  map_public_ip_on_launch = each.value.publicIPMapping

  tags = {
    Name = each.value.name
  }
}

#############################
# VPC Internet Gateway
#############################

resource "aws_internet_gateway" "custom_vpc_gw" {
  vpc_id = aws_vpc.custom_vpc.id

  tags = {
    Name = var.custom_vpc.vpc_name
  }
}

#############################
# Nat Gateway
#############################

resource "aws_eip" "nat_gw_ip" {
  vpc = true
  tags = {
    Name = var.nat_gw_ip.nat_gw_ip_name
  }
}

resource "aws_nat_gateway" "vpc_nat_gw" {
  allocation_id = aws_eip.nat_gw_ip.id
  subnet_id     = aws_subnet.public_subnets["Public-Subnet-1a"].id
  depends_on    = [aws_internet_gateway.custom_vpc_gw]
  tags = {
    Name = var.vpc_nat_gw_config.nat_gw_name
  }
}

#############################
# VPC Route Tables
#############################

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.custom_vpc.id

  route {
    cidr_block = var.public_route_config.cidr_block
    gateway_id = aws_internet_gateway.custom_vpc_gw.id
  }

  tags = {
    Name = var.public_route_config.public_route_name
  }
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.custom_vpc.id

  route {
    cidr_block     = var.private_route_config.cidr_block
    nat_gateway_id = aws_nat_gateway.vpc_nat_gw.id
  }

  tags = {
    Name = var.private_route_config.private_route_name
  }
}
#############################
# Route Tables Association
#############################

resource "aws_route_table_association" "public_route_tb" {
  for_each       = var.public_subnets_config
  subnet_id      = aws_subnet.public_subnets[each.key].id
  route_table_id = aws_route_table.public_route_table.id

}

resource "aws_route_table_association" "private_route_tb" {
  for_each       = var.private_subnets_config
  subnet_id      = aws_subnet.private_subnets[each.key].id
  route_table_id = aws_route_table.private_route_table.id

}

#############################
# Output Values
#############################

output "subnetids" {
  value = { for subnetids, group in aws_subnet.private_subnets : subnetids => group.id }
}

