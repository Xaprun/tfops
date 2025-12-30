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

  ####################################
  # Core
  ####################################
  aks_cluster_name    = var.aks_cluster_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  vnet_subnet_id      = azurerm_subnet.subnet.id

  dns_prefix          = var.dns_prefix
  kubernetes_version  = var.kubernetes_version

  ####################################
  # API / Access
  ####################################
  private_cluster_enabled            = var.private_cluster_enabled
  api_server_authorized_ip_ranges    = var.api_server_authorized_ip_ranges

  ####################################
  # Identity / RBAC
  ####################################
  tenant_id                     = var.tenant_id
  aad_admin_group_object_ids     = var.aad_admin_group_object_ids
  local_account_disabled         = var.local_account_disabled

  ####################################
  # System Node Pool
  ####################################
  system_node_pool_name = var.system_node_pool_name
  node_count            = var.node_count
  node_vm_size          = var.node_vm_size
  system_max_pods       = var.system_max_pods

  ####################################
  # Networking
  ####################################
  network_policy = var.network_policy
  dns_service_ip = var.dns_service_ip
  service_cidr   = var.service_cidr

  ####################################
  # Additional Node Pool
  ####################################
  enable_additional_pool               = var.enable_additional_pool
  additional_pool_mode                 = var.additional_pool_mode
  additional_pool_name                 = var.additional_pool_name
  additional_pool_vm_size              = var.additional_pool_vm_size
  additional_pool_enable_auto_scaling  = var.additional_pool_enable_auto_scaling
  additional_pool_min_count            = var.additional_pool_min_count
  additional_pool_max_count            = var.additional_pool_max_count
  additional_pool_node_count           = var.additional_pool_node_count
  additional_pool_max_pods             = var.additional_pool_max_pods
  additional_pool_spot_max_price       = var.additional_pool_spot_max_price

  ####################################
  # Observability
  ####################################
  enable_oms_agent          = var.enable_oms_agent
  enable_managed_prometheus = var.enable_managed_prometheus

  ####################################
  # Tags
  ####################################
  tags        = var.tags
  environment = var.environment
}
