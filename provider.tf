terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.55.0" # If starting a new project, change it to the latest version
    }
    # More details: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs
  }

  backend "azurerm" {
    resource_group_name  = "myprojecttfstate" # This resource group must already exist
    storage_account_name = "myprojecttfstate" # This storage account must already exist
    container_name       = "tfstate"
    key                  = "infra.tfstate"
  }
  # More details: https://developer.hashicorp.com/terraform/language/settings/backends/azurerm
}

provider "azurerm" {
  features {}
}
