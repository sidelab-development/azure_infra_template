resource "azurerm_mssql_server" "mssql_server" {
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
  }
}

resource "azurerm_mssql_database" "mssql_database" {
  name      = "${var.project_name}sample"
  server_id = azurerm_mssql_server.mssql_server.id

  tags = {
    Project     = "${var.project_name}sample"
    Environment = var.environment
    Service     = "mssql_database"
    Location    = var.location
    ServiceName = var.project_name
  }
}
