data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

data "aws_secretsmanager_secret" "secrets" {
  name = "dev-skillset-sm-10"
}

data "aws_secretsmanager_secret_version" "app_secrets" {
  secret_id = data.aws_secretsmanager_secret.secrets.arn
}

locals  {
  value = data.aws_secretsmanager_secret_version.app_secrets.arn
}

locals {
  username       = "${local.value}:username::"
  password       = "${local.value}:password::"
  app_secret_key = "${local.value}:app_secret_key::"
}