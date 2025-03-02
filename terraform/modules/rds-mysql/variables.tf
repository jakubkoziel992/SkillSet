variable "vpc_id" {}

variable "ec2_SG" {
  description = "EC2 SG id from EC2 module"
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

variable "DB_ingress_rules" {
  description = "Mysql ingress rule"
  type = map(object({
    description                  = string
    security_group_id            = optional(string)
    port                         = number
    ip_protocol                  = string
    referenced_security_group_id = string
  }))
}

variable "db_subnets" {
  description = "DB subnets id"
  type        = list(string)
}



