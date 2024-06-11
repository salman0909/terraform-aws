# Security Group Resources
resource "aws_security_group" "alb_security_group" {
  name        = "eoc-alb-security-group"
  description = "ALB Security Group"
  vpc_id      = aws_vpc.lb_vpc.id
  ingress {
    description = "HTTP from Internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "eoc-application-loadbalancer-security-group"
  }
}
