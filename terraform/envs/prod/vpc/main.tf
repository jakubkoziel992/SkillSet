module "vpc" {
  source       = "../../../modules/vpc"
  project_name = "skillset"
  environment  = "prod"
  cidr_block   = "172.20.0.0/16"
  public_subnets = {
    "skillset-pub-subnet-01" = {
      subnet_cidr             = "172.20.1.0/24"
      availability_zone       = "us-east-1a"
      map_public_ip_on_launch = true
    }
    "skillset-pub-subnet-02" = {
      subnet_cidr             = "172.20.2.0/24"
      availability_zone       = "us-east-1b"
      map_public_ip_on_launch = true
    }
  }

  private_subnets = {
    "skillset-priv-subnet-01" = {
      subnet_cidr             = "172.20.3.0/24"
      availability_zone       = "us-east-1a"
      map_public_ip_on_launch = false
    }
    "skillset-priv-subnet-02" = {
      subnet_cidr             = "172.20.4.0/24"
      availability_zone       = "us-east-1b"
      map_public_ip_on_launch = false
    }
  }
}
