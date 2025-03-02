module "vpc" {
  source     = "../modules/vpc"
  name       = "skillset"
  cidr_block = "172.20.0.0/16"
  public_subnets = {
    "skillset-subnet-01" = {
      subnet_cidr             = "172.20.1.0/24"
      availability_zone       = "us-east-1a"
      map_public_ip_on_launch = true
    }
    "skillset-subnet-02" = {
      subnet_cidr             = "172.20.2.0/24"
      availability_zone       = "us-east-1b"
      map_public_ip_on_launch = true
    }
  }
}
