resource "aws_instance" "eoc-instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
  associate_public_ip_address = true
  key_name = aws_key_pair.key_pair.key_name
  security_groups = [aws_security_group.ssh-allowed]
  tags = [
      Name = "eoc-instance"
}

#create a Pem file formatted private key
resource "tls_private_key" "rsa-4096" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
# create a aws key pair resource
resource "aws_key_pair" "key_pair" {
  key_name   = "my-key"
  public_key = "tls_private_key.rsa-4096.public_key_openssh"
}
#create a VPC
resource "aws_vpc" "main-vpc" {
  cidr_block = "10.0.0.0/16"
}
tags {
    Name = "main-vpc"
  }
}

#create a public Subnet
resource “aws_subnet” “dev-subnet-public-1” {
  vpc_id = “${aws_vpc.main-vpc.id}”
  availability_zone = var.aws_region

tags {
     Name = "dev-subnet-public-1"
  }
}

#create a Security Group
resource "aws_security_group" "ssh-allowed" {
    vpc_id = "${aws_vpc.main-vpc.id}"
    
    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
} 
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags {
        Name = "ssh-allowed"
    }
}

