resource "aws_vpc" "skillset_vpc" {
  cidr_block           = var.cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.name}-vpc"
  }
}


resource "aws_subnet" "public_subnet" {
  for_each = var.public_subnets
  vpc_id                  = aws_vpc.skillset_vpc.id
  cidr_block              = each.value.subnet_cidr
  availability_zone       = each.value.availability_zone
  map_public_ip_on_launch = each.value.map_public_ip_on_launch
  tags = {
    Name = each.key
  }
}