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

data "aws_secretsmanager_secret" "secrets" {
  name = "dev-skillset-sm-2"
}

data "aws_secretsmanager_secret_version" "app_secrets" {
  secret_id = data.aws_secretsmanager_secret.secrets.id
}

locals {
  value = jsondecode(data.aws_secretsmanager_secret_version.app_secrets.secret_string)
}

locals {
  username       = local.value["username"]
  password       = local.value["password"]
  app_secret_key = local.value["app_secret_key"]
}
