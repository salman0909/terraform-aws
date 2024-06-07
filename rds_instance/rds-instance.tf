resource "aws_db_instance" "eoc_db" {
  engine                 = var.engine
  engine_version         = var.engine_version
  multi_az               = false
  identifier             = var.identifier
  username               = var.username
  password               = var.db_password
  instance_class         = var.instance_class
  allocated_storage      = 20
  db_subnet_group_name   = aws_db_subnet_group.database_subnet_group.name
  vpc_security_group_ids = [aws_security_group.database_security_group.id]
  availability_zone      = data.aws_availability_zones.available_zones.names[0]
  db_name                = var.db_name
  skip_final_snapshot    = true
  tags = {
    Name = "eoc-database"
}
