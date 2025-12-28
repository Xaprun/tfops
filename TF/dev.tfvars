resource_group_name = "rg-aks-dev-weu-02"
aks_cluster_name    = "aks-dev-weu-02"

vnet_name   = "vnet-aks-dev-weu-02"
subnet_name = "snet-aks-dev-weu-02"

environment = "dev"

# Na start nie blokuj się:
api_server_authorized_ip_ranges = null

node_count   = 1
node_vm_size = "Standard_B2s_v2"

enable_additional_pool = false

tags = {
  Owner = "itsaj"
  Cost  = "lab"
}

