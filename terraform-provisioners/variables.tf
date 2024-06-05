variable "access_key" {
  sensitive = true
}
variable "secret_access_key" {
  sensitive = true
}

variable "aws_region" {
  type = string
  description = "AWS Region"
  default = "us-east-2" //chnage to your desired region
}

variable "instance_type" {
  description = "Instance type for EC2 Instance"
  type = string
  default = "t2.micro"
}
variable "cidr" {
  default = "10.0.0.0/16"
}
variable "key_name" {
  default = "mykey.pem"
}
