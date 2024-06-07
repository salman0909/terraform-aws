variable "access_key" {
  sensitive = true
}
variable "secret_access_key" {
  sensitive = true
}

variable "engine" {
  default     = "postgres"
  description = "Engine type, here it is postgres"
}
variable "engine_version" {
  description = "Engine version"
  default     = "14.1"
}
variable "identifier" {
  default     = "eocdb-rds"
  description = "Identifier for your DB"
}
variable "username" {
  default     = "eocadmin"
  description = "User name"
}
variable "db_password" {
  sensitive = true
}
variable "instance_class" {
  description = "Instance class for RDS Instance"
  default     = "db.t3.micro"
}
variable "db_name" {
  description = "Name of the Database"
  type        = string
  default     = "applicationdb"
}
