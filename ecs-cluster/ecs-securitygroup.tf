resource "aws_security_group" "sg" {
  name = "ecs-sg"
description = "Security group for ECS cluster"
  vpc_id = aws_vpc.main_vpc.id

  ingress {
    from_port = 80
    to_port =   80
    protocol = "tcp"
    self = "false"
    cidr_blocks = [ "0.0.0.0/0" ]
    description = "Allow HTTP traffic"
  }

  egress {
    description = "Allow all outbound traffic"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
}