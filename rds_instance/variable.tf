variable "access_key" {

}
variable "secret_access_key" {
 
}

variable "aws_region" {
  type = string
  description = "AWS Region"
  default = "us-east-2" //chnage to your desired region
}

variable "engine" {
  default     = "mysql"
  description = "Engine type, here it is mysql"
}
variable "engine_version" {
  description = "Engine version"

  default = {
    mysql    = "8.0.31"
  }
}

variable "identifier" {
  default     = "eocdb-rds"
  description = "Identifier for your DB"
}
variable "username" {
  default     = "eoc-admin"
  description = "User name"
}
variable "db_password" {
  description = "password, provide through your ENV variables"
  sensitive   = true
}

variable "instance_class" {
  description = "Instance class for RDS Instance"
  type = string
  default = "db.t2.micro"
}
variable "db_name" {
  description = "Name of the Database"
  type = string
  default = "applicationdb"
}
