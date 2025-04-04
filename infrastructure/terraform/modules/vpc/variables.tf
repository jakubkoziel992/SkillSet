variable "project_name" {
  description = "The project name"
  type        = string
}

variable "environment" {
  description = "The name of the deployment environment"
  type        = string
}

variable "cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnets" {
  description = "Map of public subnets"
  type = map(object({
    subnet_cidr             = string
    availability_zone       = string
    map_public_ip_on_launch = bool
  }))
}

variable "private_subnets" {
  description = "Map of private subnets"
  type = map(object({
    subnet_cidr             = string
    availability_zone       = string
    map_public_ip_on_launch = bool
  }))
}