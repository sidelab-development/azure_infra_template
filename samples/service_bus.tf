resource "azurerm_servicebus_namespace" "sb" {
  # Reference: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/servicebus_namespace
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

resource "azurerm_servicebus_queue" "sample_queue" {
  name         = "sample"
  namespace_id = azurerm_servicebus_namespace.sb.id
}
