terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.30.1"
    }
  }
}
provider "aws" {
  region = var.aws_region
  access_key = var.access_key
  secret_key = var.secret_access_key
}
