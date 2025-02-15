data "aws_region" "current" {}

data "aws_vpc" "default" {
  default = true
}

data "http" "myip" {
  url = "https://ifconfig.io"
}
