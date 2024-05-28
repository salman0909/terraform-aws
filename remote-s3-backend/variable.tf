variable "access_key" {

}
variable "secret_access_key" {
 
}
variable "ami_id" {
  type = string
  description = "AMI ID for EC2 instance"
  default = "ami-0a0277ba899dd9fd3" //specify with AMI ID
}
variable "instance_type" {
  description = "Instance type for EC2 Instance"
  type = string
  default = "t2.micro"
}
