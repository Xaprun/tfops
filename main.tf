provider "azurerm" {
  features {}
  client_id       = jsondecode(base64decode(var.azure_credentials)).clientId
  client_secret   = jsondecode(base64decode(var.azure_credentials)).clientSecret
  subscription_id = jsondecode(base64decode(var.azure_credentials)).subscriptionId
  tenant_id       = jsondecode(base64decode(var.azure_credentials)).tenantId
}

resource "azurerm_resource_group" "aks_rg" {
  name     = var.resource_group_name
  location = var.location
}
