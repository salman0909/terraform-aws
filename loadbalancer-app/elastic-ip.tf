resource "aws_eip" "elastic_ip" {
  tags = {
    Name = "eoc-elastic-ip"
  }
}
resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.elastic_ip.id
  subnet_id     = aws_subnet.public_subnet[0].id
  depends_on    = [aws_internet_gateway.internet_gateway]
  tags = {
    Name = "EOCInternetGateway"
  }
}
