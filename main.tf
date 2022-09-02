terraform {

  backend "s3" {
    bucket = "kaiobaleeiro-tfstate"
    key    = "kaio-baleeiro.tfstate"
    region = "us-east-1"
  }

  # backend "azurerm" {
  #   resource_group_name  = "lab-kaio"
  #   storage_account_name = "labkaio"
  #   container_name       = "kaiobaleeiro-tfstate"
  #   key                  = "kaio-baleeiro.tfstate"
  # }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.20.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.29.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

provider "azurerm" {
  features {}
}
