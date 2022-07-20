resource "azurerm_storage_account" "storage_account_sample" {
  name                     = "${var.project_name}${var.environment}"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  static_website {
    index_document     = "index.html"
    error_404_document = "index.html"
  }

  tags = {
    Project     = var.project_name
    Environment = var.environment
    Service     = "storage_account"
    Location    = var.location
    ServiceName = "${var.project_name}${var.environment}"
  }
}

resource "azurerm_storage_container" "container" {
  name                 = "sample"
  storage_account_name = azurerm_storage_account.storage_account_sample.name
}
