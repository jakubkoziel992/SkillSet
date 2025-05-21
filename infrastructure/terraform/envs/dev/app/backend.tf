terraform {
  backend "s3" {
    bucket = "terraform-state-dev20250520132536180200000001"
    key    = "app/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "terraform-remote-state-dev"
  }
}