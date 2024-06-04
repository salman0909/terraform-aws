#Elastic IP for NAT gateway
resource "aws_eip" "eoc_eip" {
  depends_on = [aws_internet_gateway.eoc_gw]
  domain     = "vpc"
  tags = {
    "Name" = "eoc_EIP_for_NAT"
  }
}

#NAT gateway for private subnets
# (for the private subnet to access internet - eg. ec2 instances downloading softwares from internet)
resource "aws_nat_gateway" "eoc_nat_for_private_subnet" {
  allocation_id = aws_eip.eoc_eip.id
  subnet_id     = aws_subnet.sh_subnet_1.id
  tags = {
    "Name" = "EOC NAT for private subnet"
  }
  depends_on = [aws_internet_gateway.eoc_gw]
}

#route table for connecting NAT
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.eoc_main.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.eoc_nat_for_private_subnet.id

  }
}

#associate route table with private subnet
resource "aws_route_table_association" "rta3" {
  subnet_id      = aws_subnet.sh_subnet_2.id
  route_table_id = aws_route_table.private_route_table.id
}
