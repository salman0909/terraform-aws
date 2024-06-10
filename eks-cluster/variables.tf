variable "access_key" {
  sensitive = true
}
variable "secret_access_key" {
  sensitive = true
}
variable "kubernetes_version" {
  default     = 1.28
  description = "kubernetes version"
}

variable "vpc_cidr" {
  default     = "10.0.0.0/16"
  description = "default CIDR range of the VPC"
}
variable "aws_region" {
  default = "us-east-2" // specify your desired region 
  description = "aws region"
}
variable "var_name" {
  default = "eks-vpc"
}
variable "key_name" {
  default = "eks-key"
}
