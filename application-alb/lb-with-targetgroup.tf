resource "aws_lb" "eoc_lb" {
  name               = "app-lb"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.sg_for_elb.id]
  subnets            = [aws_subnet.sh_subnet_1.id, aws_subnet.sh_subnet_1a.id]
  depends_on         = [aws_internet_gateway.eoc_gw]
}

resource "aws_lb_target_group" "eoc_alb_tg" {
  name     = "eoc-alb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.eoc_main.id
}
resource "aws_lb_listener" "eoc_frontend" {
  load_balancer_arn = aws_lb.eoc_lb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.eoc_alb_tg.arn
  }
}
