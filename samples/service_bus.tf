resource "azurerm_servicebus_namespace" "sb_namespace" {
  name                = "${var.project_name}${var.environment}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  sku                 = "Standard"

  tags = {
    Project     = var.project_name
    Environment = var.environment
    Service     = "service_bus"
    Location    = var.location
    ServiceName = "${var.project_name}${var.environment}"
  }
}

resource "azurerm_servicebus_queue" "queue" {
  name         = "sample"
  namespace_id = azurerm_servicebus_namespace.sb_namespace.id
}
