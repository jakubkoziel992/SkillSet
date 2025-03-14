variable "name" {
  description = "Project name"
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


variable "ec2_instance_ids" {
  description = "List of EC2 instance IDs to attach to the load balancer target group"
  type        = list(string)
}