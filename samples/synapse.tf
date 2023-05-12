resource "random_password" "synapse_pass" {
  # Reference https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password
  length  = 16
  special = true
}

resource "azurerm_synapse_workspace" "synapse" {
  # Reference: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/synapse_workspace
  name                                 = "${var.project_name}-${var.environment}"
  resource_group_name                  = azurerm_resource_group.rg.name
  location                             = var.location
  storage_data_lake_gen2_filesystem_id = azurerm_storage_data_lake_gen2_filesystem.gold_fs.id
  sql_administrator_login              = "mysynapseadmin"
  sql_administrator_login_password     = random_password.synapse_pass.result

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Project     = var.project_name
    Environment = var.environment
    Service     = "synapse_workspace"
    Location    = var.location
    ServiceName = "${var.project_name}-${var.environment}"
    Department  = "Development"
    CreatedBy   = "Terraform"
  }
}

resource "azurerm_key_vault_secret" "synapse_password" {
  # Reference: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret
  name         = "synapse-password"
  value        = random_password.ingestion_db_pass.result
  key_vault_id = azurerm_key_vault.kv.id

  tags = {
    Project     = var.project_name
    Environment = var.environment
    Service     = "key_vault_secret"
    Location    = var.location
    ServiceName = "synapse-password"
    Department  = "Development"
    CreatedBy   = "Terraform"
  }
}
