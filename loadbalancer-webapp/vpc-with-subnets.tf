#VPC
resource "aws_vpc" "eoc_main" {
  cidr_block = "10.0.0.0/23" # 512 IPs
  tags = {
    Name = "eoc-vpc"
  }
}

#Creating 1st public subnet
resource "aws_subnet" "sh_subnet_1" {
  vpc_id                  = aws_vpc.eoc_main.id
  cidr_block              = "10.0.0.0/27"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-2a"
}
#Creating 2nd public subnet
resource "aws_subnet" "sh_subnet_1a" {
  vpc_id                  = aws_vpc.eoc_main.id
  cidr_block              = "10.0.0.32/27"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-2b"
}
#Creating 1st private subnet
resource "aws_subnet" "sh_subnet_2" {
  vpc_id                  = aws_vpc.eoc_main.id
  cidr_block              = "10.0.1.0/27"
  map_public_ip_on_launch = false
  availability_zone       = "us-east-2b"
}
