resource "azurerm_storage_account" "func_app_storage_account_sample" {
  # Reference: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account
  name                     = "${var.project_name}sample${var.environment}"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    Project     = var.project_name
    Environment = var.environment
    Service     = "storage_account"
    Location    = var.location
    ServiceName = "${var.project_name}sample${var.environment}"
    Department  = "Development"
    CreatedBy   = "Terraform"
  }
}

resource "azurerm_service_plan" "service_plan_sample" {
  # Reference: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/service_plan
  name                = "${var.project_name}-sample-${var.environment}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  os_type             = "Linux" # Windows, Linux, or WindowsContainer
  sku_name            = "Y1"

  tags = {
    Project     = var.project_name
    Environment = var.environment
    Service     = "service_plan"
    Location    = var.location
    ServiceName = "${var.project_name}-sample-${var.environment}"
    Department  = "Development"
    CreatedBy   = "Terraform"
  }
}

resource "azurerm_linux_function_app" "function_app_sample" {
  # Reference: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_function_app
  name                       = "${var.project_name}-sample-${var.environment}"
  resource_group_name        = azurerm_resource_group.rg.name
  location                   = var.location
  service_plan_id            = azurerm_service_plan.service_plan_sample.id
  storage_account_name       = azurerm_storage_account.func_app_storage_account_sample.name
  storage_account_access_key = azurerm_storage_account.func_app_storage_account_sample.primary_access_key

  site_config {
    application_insights_connection_string = azurerm_application_insights.application_insights.connection_string
    application_insights_key               = azurerm_application_insights.application_insights.instrumentation_key

    application_stack {
      node_version = "18"
      # dotnet_version     = "6.0"
      # java_version       = "11"
      # python_version     = "3.10"
      # use_custom_runtime = true
      # docker {
      #   registry_url      = ""
      #   image_name        = ""
      #   image_tag         = ""
      #   registry_username = ""
      # }
    }

    cors {
      allowed_origins = ["http://localhost:3000"] # Add front end url
    }
  }

  app_settings = {}

  tags = {
    Project     = var.project_name
    Environment = var.environment
    Service     = "function_app"
    Location    = var.location
    ServiceName = "${var.project_name}-sample-${var.environment}"
    Department  = "Development"
    CreatedBy   = "Terraform"
  }
}
