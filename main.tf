terraform {

    backend "s3" {
        bucket = "kaio-baleeiro-tfstate"
        key = "terraform.tfstate"
        region = "us-east-1"
    }

    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~> 4.9.0"
        }
    }
}

provider "aws" {
    region = "us-east-1"
}