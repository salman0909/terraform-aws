variable "access_key" {

}
variable "secret_access_key" {
 
}

variable "aws_region" {
  type = string
  description = "AWS Region"
  default = "us-east-2" //chnage to your desired region
}

variable "instance_class" {
  description = "Instance class for RDS Instance"
  type = string
  default = "db.t2.micro"
}
variable "db_password" {
  description = "RDS root user password"
  sensitive   = true
}
