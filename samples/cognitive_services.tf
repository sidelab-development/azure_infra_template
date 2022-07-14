resource "azurerm_cognitive_account" "ocr_service_sample" {
  name                = "sample-${var.environment}"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  kind                = "ComputerVision" # more options: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cognitive_account#kind
  sku_name            = "S1"

  tags = {
    Project     = var.project_name
    Environment = var.environment
    Service     = "cognitive_account"
    Location    = var.location
    ServiceName = "sample-${var.environment}"
  }
}
