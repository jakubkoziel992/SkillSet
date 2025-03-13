data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

data "aws_subnet" "ec2_subnet" {
  availability_zone = var.availability_zone
}

data "aws_subnet" "public" {
  for_each = toset(data.aws_subnets.default_subnets.ids)
  id       = each.value
}

data "http" "myip" {
  url = "https://ifconfig.io"
}
