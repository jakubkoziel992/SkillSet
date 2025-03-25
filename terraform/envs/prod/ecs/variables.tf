variable "project_name" {
  description = "Project name"
  type        = string
  default     = "skillset"
}

variable "execution_role" {
  description = "execution role ARN"
  type        = string
  default     = "arn:aws:iam::320183397498:role/ecsTaskExecutionRole"
}

variable "database_task_definition" {
  description = "Database details"
  type = object({
    name   = string
    image  = string
    cpu    = number
    memory = number
    port_mapping = list(object({
      name          = string
      containerPort = number
      hostPort      = number
      protocol      = string
      appProtocol   = optional(string)
    }))
  })
}


variable "web_task_definition" {
  description = "web details"
  type = object({
    name   = string
    image  = string
    cpu    = number
    memory = number
    port_mapping = list(object({
      name          = string
      containerPort = number
      hostPort      = number
      protocol      = string
      appProtocol   = optional(string)
    }))
  })
}




variable "service_definitions" {
  description = "Service details"
  type = map(object({
    service_name  = string
    desired_count = number
    service = optional(object({
      port_name = string
      client_alias = object({
        dns_name = string
        port     = number
      })
    }))
    load_balancer = optional(object({
      container_name = string
      container_port = number
    }))
  }))
}

variable "ingress_rules" {
  description = "ingress rules values"
  type = map(object({
    description = string
    cidr_ipv4   = optional(string)
    port        = number
    protocol    = string
  }))
}
