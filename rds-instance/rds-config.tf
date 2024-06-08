resource "aws_db_instance" "eoc_db" {
  engine                 = var.engine
  engine_version         = var.engine_version
  identifier             = var.identifier
  username               = var.username
  password               = var.db_password
  instance_class         = var.instance_class
  allocated_storage      = 10
  db_subnet_group_name   = aws_db_subnet_group.education.name
  vpc_security_group_ids = [aws_security_group.rds.id]
  db_name                = var.db_name
  skip_final_snapshot    = true
  publicly_accessible    = true
}
