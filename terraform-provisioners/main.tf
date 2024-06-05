resource "aws_key_pair" "example" {
  key_name   = "terraform-demo-abhi"  # Replace with your desired key name
  public_key = file("~/.ssh/id_rsa.pub")  # Replace with the path to your public key file
}

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
}
