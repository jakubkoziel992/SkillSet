variable "vpc_id" {}

variable "ami_id" {
  description = "AMI ID"
  type        = string
}

variable "username" {
  type = string
}

variable "password" {
  type      = string
  sensitive = true
}

variable "db_name" {
  description = "DB name from RDS module"
  type        = string
}

variable "db_host" {
  description = "DB host from RDS module"
  type        = string
}

variable "ec2_ip" {
  description = "EC2 instance ipv4 address"
  type        = string
}

variable "availability_zone" {
  description = "Ec2 instance availability zone"
  type        = string
  default     = "us-east-1a"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "flask_app" {
  description = "FLASK_APP value"
  type        = string
  default     = "prod"
}


variable "volume_size" {
  description = "Device volume size"
  type        = string
  default     = "20"
}

variable "key_algorithm" {
  description = "SSH key algorithm"
  type        = string
  default     = "RSA"
}

variable "key_name" {
  description = "SSH key name"
  type        = string
  default     = "flask-app"
}

variable "ingress_rules" {
  description = "EC2 instance ingress rules"
  type = map(object({
    description = string
    security_group_id = optional(string)
    cidr_ipv4 = string
    from_port = number
    ip_protocol = string
    to_port = number
  }))
  default = {
    "allow-ssh" = {
      description = "Allow ssh"
      cidr_ipv4   = "0.0.0.0/0" 
      from_port   = 22
      to_port     = 22
      ip_protocol = "tcp"
      
    },
    "allow-http" = {
      description = "allow_all_traffic_to_port_80"
      cidr_ipv4 = "0.0.0.0/0"
      from_port   = 80
      to_port     = 80
      ip_protocol = "tcp"
      
    }
  }
}