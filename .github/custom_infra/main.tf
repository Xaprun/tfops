provider "azurerm" {
  features {}
}

module "aks" {
  source = "git::https://github.com/Xaprun/tfmodules.git//aks/aks_spot"

  aks_cluster_name = "aks-spot-cluster"
  location         = "West Europe"
  resource_group_name = "aks-spot-rg"

  node_count   = 1
  node_vm_size = "Standard_DS2_v2"

  # Użycie dodatkowej puli
  enable_additional_pool      = false
  additional_pool_mode        = "Spot"
  additional_pool_name        = "spotpool"
  additional_pool_vm_size     = "Standard_DS2_v2"
  additional_pool_node_count  = 2
  additional_pool_min_count   = 1
  additional_pool_max_count   = 5
}
