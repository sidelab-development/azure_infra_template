data "azurerm_key_vault_secret" "some_secret_key" {
  name         = "some-secret-key"
  key_vault_id = azurerm_key_vault.kv.id
}

resource "azurerm_storage_account" "sample_ms" {
  # Reference: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account
  name                     = "${var.project_name}samplems${var.environment}"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    Project     = var.project_name
    Environment = var.environment
    Service     = "storage_account"
    Location    = var.location
    ServiceName = "${var.project_name}samplems${var.environment}"
    Department  = "Development"
    CreatedBy   = "Terraform"
  }
}

resource "azurerm_service_plan" "sample_ms" {
  # Reference: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/service_plan
  name                = "${var.project_name}-sample-ms-${var.environment}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  os_type             = "Linux" # Windows, Linux, or WindowsContainer
  sku_name            = "Y1"

  tags = {
    Project     = var.project_name
    Environment = var.environment
    Service     = "service_plan"
    Location    = var.location
    ServiceName = "${var.project_name}-sample-ms-${var.environment}"
    Department  = "Development"
    CreatedBy   = "Terraform"
  }
}

resource "azurerm_linux_function_app" "sample_ms" {
  # Reference: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_function_app
  name                       = "${var.project_name}-sample-ms-${var.environment}"
  resource_group_name        = azurerm_resource_group.rg.name
  location                   = var.location
  service_plan_id            = azurerm_service_plan.service_plan_sample.id
  storage_account_name       = azurerm_storage_account.sample_ms.name
  storage_account_access_key = azurerm_storage_account.sample_ms.primary_access_key

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
      allowed_origins = var.environment == "dev" ? [
        "https://my-dev-front-end.com", # Change it to your dev front end url
        "http://localhost:5173"         # Change it to your local front end url
      ] : []                            # Empty array for other environments
    }
  }

  app_settings = {
    # Use secrets from key vault to avoid storing secrets in the code
    SOME_SECRET_KEY = data.azurerm_key_vault_secret.some_secret_key.value

    ENVIRONMENT = var.environment

    # database connection string
    # for node.js
    DATABASE_URL = "sqlserver://${azurerm_mssql_server.portal_db_server.fully_qualified_domain_name};database=${azurerm_mssql_database.portal_db.name};user=${azurerm_mssql_server.portal_db_server.administrator_login};password=${azurerm_mssql_server.portal_db_server.administrator_login_password};encrypt=true"
    # for python
    DATABASE_URL = "mssql+pymssql://${azurerm_mssql_server.ingestion_db_server.administrator_login}:${azurerm_mssql_server.ingestion_db_server.administrator_login_password}@${azurerm_mssql_server.ingestion_db_server.fully_qualified_domain_name}:1433/${azurerm_mssql_database.ingestion_db.name}"

    # service bus
    SERVICE_BUS_CONNECTION_STRING = azurerm_servicebus_namespace.sb.default_primary_connection_string
    SERVICE_BUS_SAMPLE_QUEUE      = azurerm_servicebus_queue.sample_queue.name

    # data lake
    DATA_LAKE_ACCOUNT_NAME = azurerm_storage_account.dl_storage_acc.name
    DATA_LAKE_ACCOUNT_KEY  = azurerm_storage_account.dl_storage_acc.primary_access_key
  }

  tags = {
    Project     = var.project_name
    Environment = var.environment
    Service     = "function_app"
    Location    = var.location
    ServiceName = "${var.project_name}-sample-ms-${var.environment}"
    Department  = "Development"
    CreatedBy   = "Terraform"
  }
}
