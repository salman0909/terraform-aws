resource "aws_instance" "eoc-instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
  vpc_security_group_ids = [ aws_security_group.vpc-ssh.id, aws_security_group.vpc-web.id ]
  count = lenght(var.instance_name)
  tags = {
      "Name" = "var.instance_name[count.index]"
   }
}
