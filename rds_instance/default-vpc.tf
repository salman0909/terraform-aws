#create default vpc if one does not exists
resource "aws_default_vpc" "default_vpc" {
  tags = {
    Name = "default-VPC"
  }
}
#Use data source to get all availability zones in region
data "aws_availability_zones" "available_zones" {

}
#Create a default subnet in the first availabilty zone if doesnt exists
resource "aws_default_subnet" "subnet_az1" {
  availability_zone = data.aws_availability_zones.available_zones.names[0]
  tags = {
    Name = "rds-default-subnet1"
  } 
}
#Create a default subnet in the second availability zone if doesnt exists
resource "aws_default_subnet" "subnet_az2" {
  availability_zone = data.aws_availability_zones.available_zones.names[1]
  tags = {
    Name = "rds-default-subnet1"
  } 
}
resource "aws_db_subnet_group" "database_subnet_group" {
  name        = "database-subnets"
  subnet_ids  = [aws_default_subnet.subnet_az1.id, aws_default_subnet.subnet_az2.id]
  description = "subnets for database instance"

  tags = {
    Name = "database-subnets"
  }
}
