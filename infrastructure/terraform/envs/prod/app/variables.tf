variable "project_name" {
  description = "The project name"
  type        = string
}

variable "environment" {
  description = "The name of the deployment environment"
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
  description = "Database name"
  type        = string
}

variable "engine" {
  description = "Database engine"
  type        = string
}

variable "engine_version" {
  description = "Database engine version"
  type        = string
}

variable "instance_class" {
  description = "Database instance class"
  type        = string
}

variable "allocated_storage" {
  description = "Allocated storage for the DB"
  type        = number
}

variable "instance_identifier" {
  description = "The DB instance identifier"
  type        = string
}

variable "parameter_group_name" {
  description = "value"
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
  sensitive   = true
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


variable "snapshot" {
  description = "final snapshot for the DB"
  type        = bool
}

variable "public_access" {
  description = "public_acces to the DB"
  type        = bool
}

variable "multi_az" {
  description = "define if DB is created in multiple availability zone"
  type        = bool
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

variable "DB_ingress_rules" {
  description = "Mysql ingress rule"
  type = map(object({
    description                  = string
    security_group_id            = optional(string)
    port                         = number
    ip_protocol                  = string
    referenced_security_group_id = optional(string)
  }))
}

variable "alb_ingress_rules" {
  description = "ingress rules values"
  type = map(object({
    description = string
    cidr_ipv4   = optional(string)
    port        = number
    protocol    = string
  }))
}

# variable "subnet_id" {
#   description = "ec2 subnet id"
#   type        = string
# }

# variable "private_subnets" {
#   description = "DB subnets id"
#   type        = list(string)
# }