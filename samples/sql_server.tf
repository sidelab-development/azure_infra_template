resource "random_password" "sample_db_pass" {
  length  = 16
  special = true
}

resource "azurerm_mssql_server" "sample_db_server" {
  # Reference: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_server
  name                         = "${var.project_name}sample${var.environment}"
  resource_group_name          = azurerm_resource_group.rg.name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = "sampleadmin"
  administrator_login_password = random_password.sample_db_pass.result

  tags = {
    Project     = var.project_name
    Environment = var.environment
    Service     = "mssql_server"
    Location    = var.location
    ServiceName = "${var.project_name}sample${var.environment}"
    Department  = "Development"
    CreatedBy   = "Terraform"
  }
}

resource "azurerm_mssql_database" "sample_db" {
  # Reference: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_database
  name        = "main"
  server_id   = azurerm_mssql_server.sample_db_server.id
  sku_name    = "Basic"
  max_size_gb = 2

  tags = {
    Project     = var.project_name
    Environment = var.environment
    Service     = "mssql_database"
    Location    = var.location
    ServiceName = "main"
    Department  = "Development"
    CreatedBy   = "Terraform"
  }
}

resource "azurerm_key_vault_secret" "sample_db_conn_string" {
  # Reference: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret
  name = "sample-db-conn-string"

  # for nodejs backend
  # value        = "sqlserver://${azurerm_mssql_server.sample_db_server.fully_qualified_domain_name};database=${azurerm_mssql_database.sample_db.name};user=${azurerm_mssql_server.sample_db_server.administrator_login};password=${azurerm_mssql_server.sample_db_server.administrator_login_password};encrypt=true"

  # for python backend
  # value        = "mssql+pymssql://${azurerm_mssql_server.sample_db_server.administrator_login}:${azurerm_mssql_server.sample_db_server.administrator_login_password}@${azurerm_mssql_server.sample_db_server.fully_qualified_domain_name}:1433/${azurerm_mssql_database.sample_db.name}"

  key_vault_id = azurerm_key_vault.kv.id

  tags = {
    Project     = var.project_name
    Environment = var.environment
    Service     = "key_vault_secret"
    Location    = var.location
    ServiceName = "sample-db-conn-string"
    Department  = "Development"
    CreatedBy   = "Terraform"
  }
}
