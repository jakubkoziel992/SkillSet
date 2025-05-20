terraform {
  backend "s3" {
    bucket = "terraform-state-prod20250520042617698000000001"
    key    = "vpc/terraform.tfstate"
    region = "us-east-1"
  }
}