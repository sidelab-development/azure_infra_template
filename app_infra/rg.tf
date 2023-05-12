resource "azurerm_resource_group" "rg" {
  # Reference: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group
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
