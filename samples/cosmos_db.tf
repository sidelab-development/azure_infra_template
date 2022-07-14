resource "azurerm_cosmosdb_account" "cosmosdb_sample" {
  name                = "${var.project_name}${var.environment}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  offer_type          = "Standard"

  consistency_policy {
    consistency_level = "Session" # BoundedStaleness, Eventual, Session, Strong or ConsistentPrefix
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
  }
}
output "cosmosdb_sample_endpoint" {
  value       = azurerm_cosmosdb_account.cosmosdb_sample.endpoint
  description = "CosmosDB sample endpoint"
}

resource "azurerm_cosmosdb_sql_database" "sql_db_sample" {
  name                = "sample"
  resource_group_name = azurerm_resource_group.rg.name
  account_name        = azurerm_cosmosdb_account.cosmosdb.name
}
output "sql_db_sample_name" {
  value       = azurerm_cosmosdb_sql_database.sql_db_sample.name
  description = "DB sample name"
}

resource "azurerm_cosmosdb_sql_container" "container_sample" {
  name                = "sample"
  resource_group_name = azurerm_resource_group.rg.name
  account_name        = azurerm_cosmosdb_account.cosmosdb.name
  database_name       = azurerm_cosmosdb_sql_database.sql_db.name
  partition_key_path  = "/id"
  throughput          = 400
}
output "container_sample_name" {
  value       = azurerm_cosmosdb_sql_container.container_sample.name
  description = "Container sample name"
}

resource "azurerm_key_vault_secret" "cosmos_db_key_sample" {
  name         = "cosmos-db-key-${var.environment}"
  value        = azurerm_cosmosdb_account.cosmosdb_sample.primary_key
  key_vault_id = azurerm_key_vault.kv.id
}
