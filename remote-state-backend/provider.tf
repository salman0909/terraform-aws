terraform {
  backend "s3" {
    bucket = "eocbucketstorebackend2024"
    dynamodb_table = "state-lock"
    key  = "eoc/mystatefile/terraform.tfstate"
    region = "us-east-2"
}
}

provider "aws" {
  region     = "us-east-2"
  access_key = var.access_key
  secret_key = var.secret_access_key
}
