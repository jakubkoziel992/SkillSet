data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

data "http" "myip" {
  url = "https://ifconfig.io"
}


data "aws_subnet" "public" {
  for_each = toset(data.aws_subnets.default_subnets.ids)
  id       = each.value
}

data "terraform_remote_state" "app" {
  backend = "local"
  config = {
    path = "../app/terraform.tfstate"
  }
}

# output "public_subnets" {
#   value = [for subnet in data.aws_subnet.public: subnet.id]
# }


