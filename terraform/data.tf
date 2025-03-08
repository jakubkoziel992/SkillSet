data "aws_region" "current" {}

data "aws_vpc" "vpc" {
  filter {
    name   = "tag:Name"
    values = ["skillset-vpc"]
  }
}

data "http" "myip" {
  url = "https://ifconfig.io"
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["amazon"]


  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "terraform_remote_state" "vpc" {
  backend = "local"
  config = {
    path = "./vpc/terraform.tfstate"
  }
}

# output "private_subnet_ids" {
#   value = data.terraform_remote_state.vpc.outputs.private_subnets
# }
