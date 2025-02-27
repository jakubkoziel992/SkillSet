variable "username" {
  type = string
}

variable "password" {
  type      = string
  sensitive = true
}

variable "db_name" {
  description = "Database name"
  type        = string
  #default     = "skillset"
}

variable "engine" {
  description = "Database engine"
  type        = string
  #default     = "mysql"
}

variable "engine_version" {
  description = "Database engine version"
  type        = string
  #default     = "8.0.40"
}

variable "instance_class" {
  description = "Database instance class"
  type        = string
  #default     = "db.t3.micro"
}

variable "allocated_storage" {
  description = "Allocated storage for the DB"
  type        = number
  #default     = 10
}

variable "instance_identifier" {
  description = "The DB instance identifier"
  type        = string
  #default     = "skillset-db"
}

variable "parameter_group_name" {
  description = "value"
  type        = string
  #default     = "default.mysql8.0"
}

variable "availability_zone" {
  description = "Ec2 instance availability zone"
  type        = string
  #default     = "us-east-1a"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  #default     = "t2.micro"
}

variable "flask_app" {
  description = "FLASK_APP value"
  type        = string
  #default     = "prod"
}


variable "volume_size" {
  description = "Device volume size"
  type        = string
  #default     = "20"
}

variable "key_algorithm" {
  description = "SSH key algorithm"
  type        = string
  #default     = "RSA"
}

variable "key_name" {
  description = "SSH key name"
  type        = string
  #default     = "flask-app"
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