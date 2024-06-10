resource "aws_security_group" "sg_for_elb" {
  name   = "sg_for_elb"
  vpc_id = aws_vpc.eoc_main.id

  ingress {
    description = "Allow http request from anywhere"
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow https request from anywhere"
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags {
   Name = "sg_for_elb"
}
}

resource "aws_security_group" "sg_for_ec2" {
  name   = "sg_for_ec2"
  vpc_id = aws_vpc.eoc_main.id

  ingress {
    description     = "Allow http request from Loadbalancer"
    protocol        = "tcp"
    from_port       = 80 # range of
    to_port         = 80 # port numbers
    security_groups = [aws_security_group.sg_for_elb.id]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
