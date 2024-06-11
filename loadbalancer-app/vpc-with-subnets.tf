data "aws_availability_zones" "available" {
  state = "available"
}
#Create a new VPC in AWS
resource "aws_vpc" "lb_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "eoc-vpc"
  }
}
#2Public Subnets
resource "aws_subnet" "public_subnet" {
  count                   = 2
  vpc_id                  = aws_vpc.lb_vpc.id
  cidr_block              = var.public_subnet_cidr[count.index]
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  tags = {
    Name = join("-", ["eoc-public-subnet", data.aws_availability_zones.available.names[count.index]])
  }
}
