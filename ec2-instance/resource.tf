resource "aws_instance" "eoc-instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id = var.subnet_id
  tags = [
      Name = "MYEC2-VM"
}
resource "aws_vpc" "main" {
  cidr_block = "172.30.0.0/16"
}

