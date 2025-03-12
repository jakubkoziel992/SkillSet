variable "vpc_id" {}

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
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "instance_name" {
  description = "EC2 instance name"
  type        = string
}

variable "flask_app" {
  description = "FLASK_APP value"
  type        = string
}

variable "app_secret_key" {
  description = "application SECRET_KEY"
  type        = string
}


variable "volume_size" {
  description = "Device volume size"
  type        = string
}

variable "key_algorithm" {
  description = "SSH key algorithm"
  type        = string
}

variable "key_name" {
  description = "SSH key name"
  type        = string
}

variable "private_key_permission" {
  description = "SSH key permissions"
  type        = string
}

variable "key_path" {
  description = "SSH key path"
  type        = string
}

variable "ingress_rules" {
  description = "EC2 instance ingress rules"
  type = map(object({
    description       = string
    security_group_id = optional(string)
    cidr_ipv4         = string
    from_port         = number
    ip_protocol       = string
    to_port           = number
  }))
}

variable "subnet_id" {
  description = "ec2 subnet id"
  type        = string
}