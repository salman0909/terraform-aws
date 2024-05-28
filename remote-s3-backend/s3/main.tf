terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = "us-east-2"
}

resource "aws_s3_bucket" "terraform-state" {
  bucket = "eoc_bucketd"
}

resource "aws_s3_bucket_versioning" "terraform-state" {
  bucket = aws_s3_bucket.eoc_bucketd.id
  versioning_configuration {
    status = "Enabled"
  }
}
