data "aws_region" "current" {}

data "aws_vpc" "default" {
  default = true
}

data "http" "myip" {
  url = "https://ifconfig.io"
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["amazon"]
  #image_owner_alias = "amazon"

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
