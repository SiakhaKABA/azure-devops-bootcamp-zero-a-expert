# modules/storage/versions.tf
terraform {
  required_version = ">= 1.11.0, < 2.0.0"
  
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.27"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.7"
    }
  }
}