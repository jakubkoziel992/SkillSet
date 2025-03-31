data "aws_vpc" "vpc" {
  filter {
    name   = "tag:Name"
    values = ["skillset-prod-vpc"]
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
  name = "skillset-prod-secrets"
}


locals {
  value = data.aws_secretsmanager_secret.secrets.arn
}

locals {
  username       = "${local.value}:username::"
  password       = "${local.value}:password::"
  app_secret_key = "${local.value}:app_secret_key::"
}

data "aws_iam_policy_document" "getsecrets" {
  version = "2012-10-17"
  statement {
    sid       = "retrieveSecrets"
    effect    = "Allow"
    actions   = ["secretsmanager:GetSecretValue"]
    resources = [data.aws_secretsmanager_secret.secrets.arn]
  }
}