resource "azurerm_resource_group" "rg" {
  name     = "${var.project_name}-${var.environment}"
  location = var.location
}
