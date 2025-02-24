provider "azurerm" {
  features {}
}

module "aks_spot" {
  source = "git::https://github.com/Xaprun/tfmodules.git//aks/aks_spot"

  aks_cluster_name          = "my-aks-cluster"
  location                  = "West Europe"
  resource_group_name       = "my-resource-group"
  node_count                = 1
  node_vm_size              = "Standard_DS2_v2"
  enable_additional_pool    = false
  additional_pool_mode      = "Spot"
  additional_pool_name      = "spotpool"
  additional_pool_vm_size   = "Standard_DS2_v2"
  additional_pool_node_count = 2
  additional_pool_min_count  = 1
  additional_pool_max_count  = 5
}
