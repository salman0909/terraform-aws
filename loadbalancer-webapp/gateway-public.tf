#Internet gateway
resource "aws_internet_gateway" "eoc_gw" {
  vpc_id = aws_vpc.eoc_main.id
  tags = {
    Name = "eoc-internet-gw"
  }
}
#route table for public subnet - connecting to internet gateway
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.eoc_main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.eoc_gw.id
  }
  tags = {
    Name = "eoc-public-route-table"
   }
}

# associate the route table with public subnet 1
resource "aws_route_table_association" "public_subnet_route_table_association" {
  subnet_id      = aws_subnet.sh_subnet_1.id
  route_table_id = aws_route_table.public_route_table.id
}

# associate the route table with public subnet 2
resource "aws_route_table_association" "public_subnet_route_table_association2" {
  subnet_id      = aws_subnet.sh_subnet_1a.id
  route_table_id = aws_route_table.public_route_table.id
}
