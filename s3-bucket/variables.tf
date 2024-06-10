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

variable "bucketname" {
  description = "The name of the s3_bucket"
  default = "eoc-bucket"
}
