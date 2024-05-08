resource "aws_instance" "eoc-instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
 #vpc_id = var.vpc_id
#subnet_ids = var.subnet_id
}

resource "aws_vpc" "example" {
  cidr_block = "172.30.0.0/16"
  tags = {
    Name = "tf-example"
  }
}

resource "aws_subnet" "example" {
  vpc_id            = var.vpc_id
  cidr_block        = "172.30.0.0/16"
  subnet_ids = var.subnet_id

  tags = {
    Name = "tf-example"
  }
}
