provider "azurerm" {
    # The "feature" block is required for AzureRM provider 2.x. 
    # If you're using version 1.x, the "features" block is not allowed.
    version = "~>2.0"
    features {}

    subscription_id = "4a9ef912-a2e9-4795-b0ce-55b456fd2f6e"
    client_id       = "2b8e90d7-c373-405a-8832-14860484edf4"
    client_secret   = "bab673cf-708b-403f-a932-21534b059c55"
    tenant_id       = "72f988bf-86f1-41af-91ab-2d7cd011db47"
}

resource "azurerm_resource_group" "main" {
  name     = "TDRockhopperApp1"
  location = "eastus"
}

resource "azurerm_app_service_plan" "main" {
  name                = "${azurerm_resource_group.main.name}-asp"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  #  kind                = "Linux"
  #  reserved            = true

  sku {
    tier = "Basic"
    size = "B1"
  }

}

resource "azurerm_app_service" "main" {
  name                = "${azurerm_resource_group.main.name}-appservice"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  app_service_plan_id = azurerm_app_service_plan.main.id

  site_config {
    java_version           = "1.8"
    java_container         = "TOMCAT"
    java_container_version = "9.0"
  }

  identity {
    type = "SystemAssigned"
  }
}
