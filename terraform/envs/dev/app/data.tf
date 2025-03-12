data "aws_vpc" "default" {
  default = true
}

data "http" "myip" {
  url = "https://ifconfig.io"
}
