#create a VPC
resource "aws_vpc" "main-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "count-demo-vpc"
  }
}
#create a public Subnet
resource "aws_subnet" "demo-subnet" {
  vpc_id = "${aws_vpc.main-vpc.id}"
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone = "us-east-2a"
  tags = {
     Name = "count-demo-subnet"
  }
}
