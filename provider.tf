terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.10.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "sampletfstate"
    storage_account_name = "sampletfstate"
    container_name       = "tfstate"
    key                  = "infra.tfstate"
  }
}

provider "azurerm" {
  features {}
}
