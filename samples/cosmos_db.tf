resource "azurerm_cosmosdb_account" "cosmosdb_sample" {
  # Reference: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_account
  name                = "${var.project_name}${var.environment}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  offer_type          = "Standard"

  consistency_policy {
    consistency_level = "Session"
  }

  geo_location {
    location          = var.location
    failover_priority = 0
  }

  tags = {
    Project     = var.project_name
    Environment = var.environment
    Service     = "cosmosdb"
    Location    = var.location
    ServiceName = "${var.project_name}${var.environment}"
    Department  = "Development"
    CreatedBy   = "Terraform"
  }
}

resource "azurerm_cosmosdb_sql_database" "sql_db_sample" {
  # Reference: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_sql_database
  name                = "sample"
  resource_group_name = azurerm_resource_group.rg.name
  account_name        = azurerm_cosmosdb_account.cosmosdb.name
}

resource "azurerm_cosmosdb_sql_container" "container_sample" {
  # Reference: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_sql_container
  name                = "sample"
  resource_group_name = azurerm_resource_group.rg.name
  account_name        = azurerm_cosmosdb_account.cosmosdb.name
  database_name       = azurerm_cosmosdb_sql_database.sql_db.name
  partition_key_path  = "/id"
  throughput          = 400
}

resource "azurerm_key_vault_secret" "cosmos_db_key_sample" {
  # Reference: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret
  name         = "cosmos-db-key-${var.environment}"
  value        = azurerm_cosmosdb_account.cosmosdb_sample.primary_key
  key_vault_id = azurerm_key_vault.kv.id
}
