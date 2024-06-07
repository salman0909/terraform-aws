resource "aws_instance" "eoc-instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id = aws_subnet.demo-subnet.id
  security_groups = [ aws_security_group.vpc-ssh.id, aws_security_group.vpc-web.id ]
  count = length(var.instance_name)
  tags = {
      Name = var.instance_name[count.index]
   }
}
