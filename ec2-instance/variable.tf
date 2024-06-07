variable "access_key" {
  sensitive = true
}
variable "secret_access_key" {
  sensitive = true
}
variable "aws_region" {
  type = string
  description = "AWS Region"
  default = "us-east-2" //change to your desired region
}
variable "instance_type" {
  description = "Instance type for EC2 Instance"
  type = string
  default = "t2.micro"
}
variable "key_name" {
  default = "my-pem"
}
