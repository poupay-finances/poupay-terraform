terraform {
    
    backend "s3" {
        bucket = "kaio-baleeiro-tfstate"
        key = "kaio-baleeiro.tfstate"
        region = "us-east-1"
    }
    
    required_providers {
        azurerm = {
          source  = "hashicorp/azurerm"
          version = "~> 3.0.0"
        }
        aws = {
            source = "hashicorp/aws"
            version = "~> 4.9.0"
        }
    }
}

provider "aws" {
    region = "us-east-1"
}

provider "azurerm" {
    features {}
}
