terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.64.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "terraform-state-rg"
    storage_account_name = "itsajtfstatestorage"
    container_name       = "tfstate"          
    key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
  # client_id       = jsondecode(base64decode(var.azure_credentials)).clientId
  # client_secret   = jsondecode(base64decode(var.azure_credentials)).clientSecret
  # subscription_id = jsondecode(base64decode(var.azure_credentials)).subscriptionId
  # tenant_id       = jsondecode(base64decode(var.azure_credentials)).tenantId
}

module "aks_spot" {
  source = "git::https://github.com/Xaprun/tfmodules.git//aks/aks_spot"

  aks_cluster_name          = var.aks_cluster_name
  location                  = var.location
  resource_group_name       = var.resource_group_name
  node_count                = var.node_count
  node_vm_size              = var.node_vm_size
  enable_additional_pool    = var.enable_additional_pool
  additional_pool_mode      = var.additional_pool_mode
  additional_pool_name      = var.additional_pool_name
  additional_pool_vm_size   = var.additional_pool_vm_size
  additional_pool_node_count = var.additional_pool_node_count
  additional_pool_min_count  = var.additional_pool_min_count
  additional_pool_max_count  = var.additional_pool_max_count
}
