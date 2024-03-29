resource "azurerm_application_insights" "application_insights" {
  # Reference: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_insights
  name                = "${var.project_name}${var.environment}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  application_type    = "other" # ios, java, MobileCenter, Node.JS, store, web, other

  tags = {
    Project     = var.project_name
    Environment = var.environment
    Service     = "application_insights"
    Location    = var.location
    ServiceName = "${var.project_name}${var.environment}"
    Department  = "Development"
    CreatedBy   = "Terraform"
  }
}
