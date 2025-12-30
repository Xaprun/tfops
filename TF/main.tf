resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  address_space       = [var.vnet_cidr]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.subnet_cidr]
}

module "aks" {
  source = "git::https://github.com/Xaprun/tfmodules.git//aks-v202601?ref=module-aks-observability"

  aks_cluster_name      = var.aks_cluster_name
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  vnet_subnet_id        = azurerm_subnet.subnet.id

  # Jak nie wiesz co robisz -> zostaw null, bo się odetniesz od API
  api_server_authorized_ip_ranges = var.api_server_authorized_ip_ranges

  tenant_id                     = var.tenant_id
  local_account_disabled         = var.local_account_disabled
  aad_admin_group_object_ids     = var.aad_admin_group_object_ids

  node_count   = var.node_count
  node_vm_size = var.node_vm_size

  enable_additional_pool = var.enable_additional_pool
  additional_pool_mode   = var.additional_pool_mode
  additional_pool_name   = var.additional_pool_name
  additional_pool_vm_size = var.additional_pool_vm_size
  additional_pool_enable_auto_scaling = var.additional_pool_enable_auto_scaling
  additional_pool_min_count = var.additional_pool_min_count
  additional_pool_max_count = var.additional_pool_max_count

  enable_oms_agent = var.enable_oms_agent

  tags        = var.tags
  environment = var.environment

  # aks_ci_sp_object_id = var.aks_ci_sp_object_id
}


