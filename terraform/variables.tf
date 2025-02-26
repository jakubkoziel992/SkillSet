variable "username" {
  type = string
}

variable "password" {
  type      = string
  sensitive = true
}

#db
variable "db_name" {
  description = "Database name"
  type        = string
  default     = "skillset"
}

variable "engine" {
  description = "Database engine"
  type        = string
  default     = "mysql"
}

variable "engine_version" {
  description = "Database engine version"
  type        = string
  default     = "8.0.40"
}

variable "instance_class" {
  description = "Database instance class"
  type        = string
  default     = "db.t3.micro"
}

variable "allocated_storage" {
  description = "Allocated storage for the DB"
  type        = number
  default     = 10
}

variable "instance_identifier" {
  description = "The DB instance identifier"
  type        = string
  default     = "skillset-db"
}

variable "parameter_group_name" {
  description = "value"
  type        = string
  default     = "default.mysql8.0"
}