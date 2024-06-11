resource "aws_lb" "alb" {
  name               = "eoc-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_security_group.id]
  subnets            = [for i in aws_subnet.public_subnet : i.id]
}

#creating a target group that listens on port 80 and uses the HTTP protocol.
resource "aws_lb_target_group" "target_group" {
  name     = "eoc-tgrp"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.lb_vpc.id
  health_check {
    path    = "/"
    matcher = 200
  }
}
resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
  }
  tags = {
    Name = "eoc-alb-listenter"
  }
}
