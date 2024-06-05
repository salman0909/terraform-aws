#create a VPC
resource "aws_vpc" "main-vpc" {
  cidr_block = var.cidr
  tags = {
    Name = "dev-vpc"
  }
}

#create a public subnet
resource "aws_subnet" "dev-public-subnet" {
  vpc_id                  = aws_vpc.main-vpc.id
  cidr_block              = "10.0.0.0/24"
  availability_zone       = "us-east-2a"
  map_public_ip_on_launch = true
  tags = {
    Name = "public-subnet"
  }
}
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main-vpc.id
  tags = {
    Name = "public-igw"
  }
}
resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.main-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}
resource "aws_route_table_association" "rta1" {
  subnet_id      = aws_subnet.dev-public-subnet.id
  route_table_id = aws_route_table.public-rt.id
}
