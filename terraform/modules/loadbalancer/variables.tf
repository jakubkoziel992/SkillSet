variable "project_name" {
  description = "The Project name"
  type        = string
}

variable "environment" {
  description = "The name of the deployment environment"
  type        = string
}

variable "vpc_id" {}


variable "public_subnets" {
  description = "Public subnets id"
  type        = list(string)
}

variable "lb_type" {
  description = "Load balancer type"
  type        = string
}

variable "user_ip" {
  description = "user ip"
  type        = string
}

variable "ec2_instance_ids" {
  description = "List of EC2 instance IDs to attach to the load balancer target group"
  type        = list(string)
  default     = null
}

variable "target_type" {
  description = "Target group type"
  type        = string
  default     = "instance"
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

variable "enable_target_group_attachment" {
  description = "flag for launching resource"
  type        = bool
  default     = false
}