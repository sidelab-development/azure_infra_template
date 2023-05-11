resource "azurerm_mssql_server" "mssql_server_sample" {
  name                         = "${var.project_name}${var.environment}"
  resource_group_name          = azurerm_resource_group.rg.name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = ""
  administrator_login_password = ""

  tags = {
    Project     = var.project_name
    Environment = var.environment
    Service     = "mssql_server"
    Location    = var.location
    ServiceName = "${var.project_name}${var.environment}"
    Department  = "Development"
    CreatedBy   = "Terraform"
  }
}

resource "azurerm_mssql_database" "mssql_database_sample" {
  name        = "${var.project_name}sample"
  server_id   = azurerm_mssql_server.mssql_server_sample.id
  sku_name    = "Basic"
  max_size_gb = 2

  tags = {
    Project     = "${var.project_name}sample"
    Environment = var.environment
    Service     = "mssql_database"
    Location    = var.location
    ServiceName = var.project_name
    Department  = "Development"
    CreatedBy   = "Terraform"
  }
}
