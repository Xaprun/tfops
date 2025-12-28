location = "Sweden Central"

resource_group_name = "rg-aks-dev-sc-01"
aks_cluster_name    = "aks-dev-sc-01"
vnet_name   = "vnet-aks-dev-sc-01"
subnet_name = "snet-aks-dev-sc-01"

environment = "dev"

# Na start nie blokuj się:
api_server_authorized_ip_ranges = null

node_count   = 1
node_vm_size = "Standard_B4ms"

enable_additional_pool = false

tags = {
  Owner = "itsaj"
  Cost  = "lab"
}

tenant_id = "74c89afa-5815-4a03-954d-d2fc639c3448"

aad_admin_group_object_ids = [
  "f350cc08-29aa-4f3b-92cf-259e16c082a6"
]

local_account_disabled = true
