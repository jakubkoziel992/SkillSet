locals {
  ec2_map = var.enable_target_group_attachment ? { for k, v in var.ec2_instance_ids : k => v } : {}
}



resource "aws_security_group" "skillset-ELB-SG" {
  name        = "${var.project_name}-${var.environment}-ELB-SG"
  description = "Allow HTTP request from anywhere"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.project_name}-${var.environment}-ELB-SG"
  }
}

resource "aws_vpc_security_group_ingress_rule" "skillset-ELB-SG" {
  for_each                     = var.ingress_rules
  description                  = each.value.description
  security_group_id            = aws_security_group.skillset-ELB-SG.id
  cidr_ipv4                    = each.key == "http" ? "${var.user_ip}/32" : null
  from_port                    = each.value.port
  ip_protocol                  = each.value.protocol
  to_port                      = each.value.port
  referenced_security_group_id = each.value.cidr_ipv4 == null ? aws_security_group.skillset-ELB-SG.id : null
}

resource "aws_vpc_security_group_egress_rule" "skillset-ELB-SG" {
  description       = "allow outbound traffic"
  security_group_id = aws_security_group.skillset-ELB-SG.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 0
  ip_protocol       = -1
  to_port           = 0
}


resource "aws_lb" "skillset-lb" {
  name               = "${var.project_name}-${var.environment}-ELB"
  internal           = false
  load_balancer_type = var.lb_type
  security_groups    = [aws_security_group.skillset-ELB-SG.id]
  subnets            = var.public_subnets

  tags = {
    Name = "${var.project_name}-${var.environment}-ELB"
  }
}


resource "aws_lb_target_group" "target_elb" {
  name        = "${var.project_name}-${var.environment}-ELB-TG"
  port        = 8000
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = var.target_type
  health_check {
    path                = "/health"
    port                = 8000
    protocol            = "HTTP"
    healthy_threshold   = 5
    unhealthy_threshold = 5
    timeout             = 5
    interval            = 30
  }

  tags = {
    Name = "${var.project_name}-${var.environment}-ELB-TG"
  }
}

resource "aws_lb_target_group_attachment" "main" {
  #for_each         = var.enable_target_group_attachment ? toset(var.ec2_instance_ids) : toset([])
  for_each         = local.ec2_map
  target_group_arn = aws_lb_target_group.target_elb.arn
  target_id        = each.value
  port             = 8000
  depends_on       = [aws_lb_target_group.target_elb]
}

resource "aws_lb_listener" "lb_listener" {
  load_balancer_arn = aws_lb.skillset-lb.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_elb.arn
  }
}

