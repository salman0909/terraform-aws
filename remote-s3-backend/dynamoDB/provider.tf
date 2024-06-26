terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = "us-east-2"
  access_key = var.access_key
  secret_key = var.secret_access_key
}
