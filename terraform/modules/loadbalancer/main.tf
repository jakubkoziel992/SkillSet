resource "aws_security_group" "skillset-ELB-SG" {
  name        = "${var.name}-ELB-SG"
  description = "Allow HTTP request from anywhere"
  vpc_id      = var.vpc_id
  tags = {
    Name = "${var.name}-ELB-SG"
  }
}

resource "aws_vpc_security_group_ingress_rule" "skillset-ELB-SG" {
  description       = "Allow HTTP request from anywhere"
  security_group_id = aws_security_group.skillset-ELB-SG.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
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
  name               = "${var.name}-LB"
  internal           = false
  load_balancer_type = var.lb_type
  security_groups    = [aws_security_group.skillset-ELB-SG.id]
  subnets            = var.public_subnets
}


resource "aws_lb_target_group" "target_elb" {
  name        = "${var.name}-TG"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "instance"
  health_check {
    path                = "/health"
    port                = 80
    protocol            = "HTTP"
    healthy_threshold   = 5
    unhealthy_threshold = 5
    timeout             = 5
    interval            = 30
  }
}

resource "aws_lb_target_group_attachment" "main" {
  for_each         = toset(var.ec2_instance_ids)
  target_group_arn = aws_lb_target_group.target_elb.arn
  target_id        = each.value
  port             = 80
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

