resource "aws_vpc" "main_vpc" {
  cidr_block = var.vpc_cidr
  
  tags = {
    name = "main"
  }
}

resource "aws_subnet" "public_subnet" {
    vpc_id = aws_vpc.main_vpc.id
    cidr_block = cidrsubnet(aws_vpc.main_vpc, 8, 1) ## takes 10.0.0.0/16 --> 10.0.1.0/24
    map_public_ip_on_launch = true
    availability_zone = var.availability_zones
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name ="igw"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main_vpc.id

  route = {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "subnet_route" {
  subnet_id = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}