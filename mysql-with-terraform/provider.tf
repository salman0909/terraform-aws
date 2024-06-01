terraform {
  required_providers {
    mysql = {
      source  = "petoju/mysql"
      version = "3.0.60"
    }
   docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.13.0"
    }
  }
}

provider "mysql" {
  alias    = "local"
  endpoint = "127.0.0.1:3306"
  username = "root"
  password = "rootpassword"
}
