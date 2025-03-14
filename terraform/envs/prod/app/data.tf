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
