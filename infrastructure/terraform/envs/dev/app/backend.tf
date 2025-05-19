terraform {
  backend "s3" {
    bucket = "terraform-state-dev20250519120127489700000001"
    key    = "app/terraform.tfstate"
    region = "us-east-1"
  }
}