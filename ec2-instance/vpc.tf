#create a VPC
resource "aws_vpc" "main-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "main-vpc"
  }
}
#create a public Subnet
resource "aws_subnet" "dev-subnet-public-1" {
  vpc_id = "${aws_vpc.main-vpc.id}"
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone = "us-east-2a"
  tags = {
     Name = "dev-subnet-public-1"
  }
}
