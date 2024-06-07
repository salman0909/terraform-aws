resource "aws_instance" "eoc-instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
  associate_public_ip_address = true
  subnet_id = aws_subnet.dev-subnet-public-1.id
  security_groups = [aws_security_group.ssh-allowed.id]
  tags = {
      Name = "eoc-instance"
   }
}
