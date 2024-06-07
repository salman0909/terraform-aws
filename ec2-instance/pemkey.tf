#create a Pem file formatted private key
resource "tls_private_key" "rsa-4096" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
# create a aws key pair resource
resource "aws_key_pair" "key_pair" {
  key_name   = var.key_name
  public_key = tls_private_key.rsa-4096.public_key_openssh
}
#create a local file 
resource "local_file" "private_key" {
  content = tls_private_key.rsa-4096.private_key_pem
  filename = var.key_name
}
