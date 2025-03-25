data "aws_vpc" "vpc" {
  filter {
    name   = "tag:Name"
    values = ["skillset-vpc"]
  }
}

data "terraform_remote_state" "vpc" {
  backend = "local"
  config = {
    path = "../vpc/terraform.tfstate"
  }
}

data "http" "myip" {
  url = "https://ifconfig.io"
}

data "aws_secretsmanager_secret" "secrets" {
  name = "prod-skillset-secrets"
}

data "aws_secretsmanager_secret_version" "app_secrets" {
  secret_id = data.aws_secretsmanager_secret.secrets.arn
}

locals {
  value = data.aws_secretsmanager_secret_version.app_secrets.arn
}

locals {
  username       = "${local.value}:username::"
  password       = "${local.value}:password::"
  app_secret_key = "${local.value}:app_secret_key::"
}