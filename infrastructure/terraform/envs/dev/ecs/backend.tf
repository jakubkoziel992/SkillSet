terraform {
  backend "s3" {
    bucket = "terraform-state-dev20250524091442090900000001"
    key    = "ecs/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "terraform-remote-state-dev"
  }
}