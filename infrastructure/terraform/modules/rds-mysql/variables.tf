variable "vpc_id" {}

variable "rds_sg" {
  description = "Security group ID"
  type        = string
}

variable "username" {
  description = "The databse username"
  type        = string
}

variable "password" {
  description = "The database password"
  type        = string
  sensitive   = true
}

variable "project_name" {
  description = "The project name"
  type        = string
}

variable "environment" {
  description = "The name of the deployment environment"
  type        = string
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

variable "private_subnets" {
  description = "DB subnets id"
  type        = list(string)
}



