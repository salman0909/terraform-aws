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

resource "aws_instance" "terraform-state-test" {
  ami           =  var.ami_id
  instance_type = var.instance_type
  
}
