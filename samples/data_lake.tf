resource "azurerm_storage_account" "dl_storage_account" {
  # Reference: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account
  name                     = "${var.project_name}datalake${var.environment}"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  is_hns_enabled           = "true"

  tags = {
    Project     = var.project_name
    Environment = var.environment
    Service     = "storage_account"
    Location    = var.location
    ServiceName = "${var.project_name}datalake${var.environment}"
    Department  = "Development"
    CreatedBy   = "Terraform"
  }
}

resource "azurerm_storage_data_lake_gen2_filesystem" "gold_fs" {
  # Reference: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_data_lake_gen2_filesystem
  name               = "gold"
  storage_account_id = azurerm_storage_account.dl_storage_account.id
}
