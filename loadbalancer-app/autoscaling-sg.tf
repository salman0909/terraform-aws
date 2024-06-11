resource "aws_security_group" "asg_security_group" {
  name        = "eoc-asg-security-group"
  description = "ASG Security Group"
  vpc_id      = aws_vpc.lb_vpc.id
  ingress {
    description     = "HTTP from ALB"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_security_group.id]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "eoc-asg-security-group"
  }
}
