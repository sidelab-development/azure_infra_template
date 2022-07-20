resource "azurerm_key_vault" "kv_sample" {
  name                = "${var.project_name}${var.environment}"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  sku_name            = "standard"
  tenant_id           = var.tenant_id

  access_policy {
    tenant_id = var.tenant_id
    object_id = var.object_id

    secret_permissions = [
      "Get",
      "Delete",
      "Set",
      "List",
      "Recover",
      "Purge"
    ]
  }

  tags = {
    Project     = var.project_name
    Service     = "key_vault"
    Location    = var.location
    ServiceName = "${var.project_name}${var.environment}"
  }
}

resource "azurerm_key_vault_secret" "key_vault_secret" {
  name         = "sample"
  value        = "value"
  key_vault_id = azurerm_key_vault.kv.id

  tags = {
    "Project" : var.project_name
    "Environment" : var.environment
    "Service" : "key_vault_secret"
    "ServiceName" : "sample"
    "Location" : var.location
  }
}

resource "azurerm_key_vault_certificate" "key_vault_certificate" {
  name         = "sample"
  key_vault_id = azurerm_key_vault.kv.id

  certificate {
    contents = filebase64("file_path")
    password = "password"
  }

  tags = {
    "Project" : var.project_name
    "Environment" : var.environment
    "Service" : "key_vault_secret"
    "ServiceName" : "sample"
    "Location" : var.location
  }
}