resource "aws_instance" "eoc-instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
  associate_public_ip_address = true
  tags = [
      Name = "MYEC2-VM"
}

#create a Pem file formatted private key
resource "tls_private_key" "rsa-4096-example" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
# create a aws key pair resource
resource "aws_key_pair" "key_pait" {
  key_name   = "deployer-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQD3F6tyPEFEzV0LX3X8BsXdMsQz1x2cEikKDEY0aIj41qgxMCP/iteneqXSIFZBp5vizPvaoIR3Um9xK7PGoW8giupGn+EPuxIA4cDM4vzOqOkiMPhz5XK0whEjkVzTo4+S0puvDZuwIsdiW9mxhJc7tgBNL0cYlWSYVkz4G/fslNfRPW5mYAM49f4fhtxPb5ok4Q2Lg9dPKVHO/Bgeu5woMc7RY0p1ej6D4CKFE6lymSDJpW0YHX/wqE9+cfEauh7xZcG0q9t2ta6F6fmX0agvpFyZo8aFbXeUBr7osSCJNgvavWbM/06niWrOvYX2xwWdhXmXSrbX8ZbabVohBK41 email@example.com"
}
#create a VPC
resource "aws_vpc" "main-vpc" {
  cidr_block = "10.0.0.0/16"
}
tags {
    Name = "prod-vpc"
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

