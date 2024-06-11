resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.lb_vpc.id
  tags = {
    Name = "eoc-internet-gateway"
  }
}
