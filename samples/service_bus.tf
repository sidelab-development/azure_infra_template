resource "azurerm_servicebus_namespace" "sb_namespace_sample" {
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
    Department  = "Development"
    CreatedBy   = "Terraform"
  }
}

resource "azurerm_servicebus_queue" "queue_sample" {
  name         = "sample"
  namespace_id = azurerm_servicebus_namespace.sb_namespace_sample.id
}
