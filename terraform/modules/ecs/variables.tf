variable "project_name" {
  description = "Project name"
  type        = string
  default     = "skillset" 
}

variable "execution_role" {
    description = "execution role ARN"
    type    = string 
    default = "arn:aws:iam::320183397498:role/ecsTaskExecutionRole"
}

variable "service_subnets" {
  description = "Id subnets"
  type        = list(string) 
}

variable "target_group_arn" {
  description = "target group arn"
  type        = string
}

variable "security_group_id" {
  description = "Security group id"
  type        = string
}

variable "task_definitions"{
  description = "Task details"
  type        = map(object({
    name    = string
    image   = string
    cpu     = number
    memory  = number
    port_mapping = list(object({
        name = string
        containerPort = number
        hostPort = number
        protocol = string
        appProtocol = optional(string)
    }))
    env_variables = list(object({
      name = string
      value = string 
    }))
    # health_check = optional(object({
    #   command    = list(string)
    #   interval   = number
    #   timeout    = number
    #   retries    = number
    #   startPeriod = number
    # }))
  })) 
}


variable "service_definitions" {
  description = "Service details"
  type         = map(object({
    service_name = string
    desired_count = number
    service = optional(object({
      port_name = string
      client_alias = object({
        dns_name = string
        port = number
    })
  }))
    load_balancer = optional(object({
      container_name = string
      container_port = number
    }))
  }))
} 
