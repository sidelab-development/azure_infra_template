resource "azurerm_resource_group" "rg" {
  name     = "${var.project_name}-${var.environment}"
  location = var.location

  tags = {
    Project     = var.project_name
    Environment = var.environment
    Service     = "resource_group"
    Location    = var.location
    ServiceName = "${var.project_name}-${var.environment}"
    Department  = "Development"
    CreatedBy   = "Terraform"
  }
}
