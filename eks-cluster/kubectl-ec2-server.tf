data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}
resource "tls_private_key" "rsa-4096" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
resource "aws_key_pair" "example" {
  key_name   = var.key_name
  public_key = tls_private_key.rsa-4096.public_key_openssh
}

#create a local file
resource "local_file" "private_key" {
  content  = tls_private_key.rsa-4096.private_key_pem
  filename =  var.key_name
}
resource "aws_instance" "kubectl-server" {
  ami  = data.aws_ami.ubuntu.id
  key_name = aws_key_pair.example.key_name
  instance_type = "t2.small"
  associate_public_ip_address = true 
  subnet_id = aws_subnet.public-1.id
  vpc_security_group_ids = [ aws_security_group.worker_mgmt.id ]
  tags = {
    Name = "kubectl-server"
  }
}
