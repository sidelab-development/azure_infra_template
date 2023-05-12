resource "azurerm_key_vault" "kv_sample" {
  # Reference: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault
  name                = "${var.project_name}${var.environment}"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  sku_name            = "standard"
  tenant_id           = var.tenant_id

  # Uncomment the lines below to create an access policy
  # access_policy {
  #   tenant_id = var.tenant_id # or change to another tenant id
  #   object_id = "OBJECT_ID" # Change it to a existing object id

  #   secret_permissions = [
  #     "Get",
  #     "Delete",
  #     "Set",
  #     "List",
  #     "Recover",
  #     "Purge"
  #   ]
  # }

  tags = {
    Project     = var.project_name
    Service     = "key_vault"
    Location    = var.location
    ServiceName = "${var.project_name}${var.environment}"
    Department  = "Development"
    CreatedBy   = "Terraform"
  }
}

# Uncomment the lines below to create a secret
# resource "azurerm_key_vault_secret" "key_vault_secret" {
#   # Reference: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret
#   name         = "sample"
#   value        = "value"
#   key_vault_id = azurerm_key_vault.kv_sample.id

#   tags = {
#     Project     = var.project_name
#     Environment = var.environment
#     Service     = "key_vault_secret"
#     ServiceName = "sample"
#     Location    = var.location
#     Department  = "Development"
#     CreatedBy   = "Terraform"
#   }
# }

# Uncomment the lines below to create a certificate in key vault
# resource "azurerm_key_vault_certificate" "key_vault_certificate" {
#   # Reference: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_certificate
#   name         = "sample"
#   key_vault_id = azurerm_key_vault.kv_sample.id

#   certificate {
#     contents = filebase64("file_path")
#     password = "password"
#   }

#   tags = {
#     Project     = var.project_name
#     Environment = var.environment
#     Service     = "key_vault_certificate"
#     ServiceName = "sample"
#     Location    = var.location
#     Department  = "Development"
#     CreatedBy   = "Terraform"
#   }
# }
