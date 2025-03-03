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


resource "aws_subnet" "private_subnet" {
  for_each = var.private_subnets
  vpc_id                  = aws_vpc.skillset_vpc.id
  cidr_block              = each.value.subnet_cidr
  availability_zone       = each.value.availability_zone
  map_public_ip_on_launch = each.value.map_public_ip_on_launch
  tags = {
    Name = each.key
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.skillset_vpc.id

  tags = {
    Name = "${var.name}-IGW"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.skillset_vpc.id

  route {
    cidr_block = "172.20.0.0/16"
    gateway_id = "local"
  }

  route {
    cidr_block = "0.0.0.0/0"
     gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.name}-pub-RT"
  }
}

resource "aws_route_table_association" "public_association" {
  #for_each = { for k, v in var.public_subnets : k => v }
  for_each = var.public_subnets
  subnet_id      = aws_subnet.public_subnet[each.key].id
  route_table_id = aws_route_table.public_route_table.id
}