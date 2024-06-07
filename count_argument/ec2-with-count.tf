resource "aws_instance" "eoc-instance" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  subnet_id = aws_subnet.demo-subnet.id
  security_groups = [ aws_security_group.vpc-ssh.id ]
  count = length(var.instance_name)
  tags = {
      Name = var.instance_name[count.index]
   }
}
