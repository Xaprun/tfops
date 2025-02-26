aks_cluster_name = "my-aks-cluster"
location = "West Europe"
resource_group_name = "my-resource-group"

# Pula domyślna (System)
node_count = 1
node_vm_size = "Standard_DS2_v2"

# Dodatkowa pula (opcjonalna)
enable_additional_pool = false
additional_pool_mode = "Spot"
additional_pool_name = "spotpool"
additional_pool_vm_size = "Standard_DS2_v2"
additional_pool_node_count = 2
additional_pool_min_count = 1
additional_pool_max_count = 5
