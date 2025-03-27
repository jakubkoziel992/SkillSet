data "aws_vpc" "vpc" {
  filter {
    name   = "tag:Name"
    values = ["skillset-vpc"]
  }
}

data "aws_instances" "ec2_instances" {
  instance_tags = {
    Name = "skillset-web-*"
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







