terraform {

  backend "s3" {
    bucket = "kaiobaleeiro"
    key    = "kaio-baleeiro-terraform.tfstate"
    region = "us-east-1"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.9.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}
