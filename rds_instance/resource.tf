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

#Create Security Group for the webserver 
resource "aws_security_group" "webserver_security_group" {
  name     = "webserver security group"
  description = "enable http access on port 80"
  vpc_id      = aws_default_vpc.default_vpc.id

  ingress {
    description ="http access"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port  = 0
    to_port    = 0
    protocol   = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "Webserver Security group"
  }
}
#Create Security group for the Database
resource "aws_security_group" "database_security_group" {
  name        = "database security group"
  description = "enable mysql access on port 3306"
  vpc_id      = aws_default_vpc.default_vpc.id

  ingress {
    description      = "mysql access"
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    security_groups  = [aws_security_group.webserver_security_group.id]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = -1
    cidr_blocks      = ["0.0.0.0/0"]
  }
  tags = {
    Name = "Database Security group"
  }
}

resource "aws_db_subnet_group" "database_subnet_group" {
  name               = "database-subnets"
  subnet_ids         = [aws_default_subnet.subnet_az1.id, aws_default_subnet.subnet_az2.id]
  description        = "subnets for database instance"

  tags  = {
    Name = "database-subnets"
  }
}

resource "aws_db_instance" "eoc_db" {
  engine            = var.engine
  engine_version    = var.engine_version
  multi_az          = false
  identifier        = var.identifier
  username          = var.username
  password          = var.db_password
  instance_class    = var.instance_class
  allocated_storage = 20
  db_subnet_group_name = aws_db_subnet_group.database_subnet_group.name
  vpc_security_group_ids  = [aws_security_group.database_security_group.id]
  availability_zone    = data.aws_availability_zones.available_zones.names[0]
  db_name   = var.db_name
  skip_final_snapshot  = true
}

  

   
  

  
  
  
  
