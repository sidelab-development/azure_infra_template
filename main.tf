data "azurerm_client_config" "current" {}

module "app_infra" {
  source = "./app_infra"

  for_each = var.environments

  project_name = var.project_name
  environment  = each.key
  location     = each.value.location
  tenant_id    = data.azurerm_client_config.current.tenant_id
}
