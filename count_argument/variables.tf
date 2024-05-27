variable "access_key" {

}
variable "secret_access_key" {
 
}
variable "ami_id" {
  type = string
  description = "AMI ID for EC2 instance"
  default = "ami-0a0277ba899dd9fd3" //specify with AMI ID
}

variable "aws_region" {
  type = string
  description = "AWS Region"
  default = "us-east-2" //chnage to your desired region
}
variable "instance_name" {
  description = "Instance name for EC2 Instance"
  type = list(string)
  default = ["eoc-instance-01","eoc-instance-02","eoc-instance-03"]
}
variable "instance_type" {
  description = "Instance type for EC2 Instance"
  type = string
  default = "t2.micro"
}