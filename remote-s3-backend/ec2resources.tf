#create default vpc if one does not exists
resource "aws_default_vpc" "default_vpc" {
  tags = {
    Name = "default_VPC"
  }
}

#Use data source to get all availability zones in region
data "aws_availability_zones" "available_zones" {

}

#Create a default subnet in the first availabilty zone if doesnt exists
resource "aws_default_subnet" "subnet_az1" {
  availability_zone = data.aws_availability_zones.available_zones.names[0]
}

#Create a default subnet in the second availability zone if doesnt exists
resource "aws_default_subnet" "subnet_az2" {
  availability_zone = data.aws_availability_zones.available_zones.names[1]
}
#create a Security Group
resource "aws_security_group" "ssh-allowed" {
    vpc_id = aws_default_vpc.default_vpc.id
    description = "Allow SSH inbound traffic"
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
    tags = {
        Name = "ssh-allowed"
    }
}

resource "aws_instance" "terraform-state-test" {
  ami           =  var.ami_id
  instance_type = var.instance_type
  subnet_id = aws_default_subnet.subnet_az1.id
  security_groups = [aws_security_group.ssh-allowed.id]
  tags = {
      Name = "terraform-state-test"
   }
  
}
