data "aws_vpc" "vpc" {
  filter {
    name   = "tag:Name"
    values = ["skillset-vpc"]
  }
}

data "http" "myip" {
  url = "https://ifconfig.io"
}

data "terraform_remote_state" "vpc" {
  backend = "local"
  config = {
    path = "../vpc/terraform.tfstate"
  }
}

# data "aws_instances" "ec2_instances" {
#   instance_tags = {
#     Name = "skillset-web-*"
#   }
# }

data "aws_secretsmanager_secret" "secrets" {
  name = "prod-skillset-secrets"
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
