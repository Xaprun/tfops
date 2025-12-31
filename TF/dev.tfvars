location = "swedencentral"

resource_group_name = "rg-aks-dev-sc-02"
aks_cluster_name    = "aks-dev-sc-02"

vnet_name   = "vnet-aks-dev-sc-02"
subnet_name = "snet-aks-dev-sc-02"

vnet_cidr   = "10.10.0.0/16"
subnet_cidr = "10.10.1.0/24"

environment = "dev"

# Na start nie blokuj się:
api_server_authorized_ip_ranges = null

node_count   = 1
node_vm_size = "Standard_B4ms"

enable_additional_pool = false

enable_oms_agent           = true
enable_managed_prometheus  = true

tags = {
  Owner = "itsaj"
  Cost  = "lab"
}

tenant_id = "74c89afa-5815-4a03-954d-d2fc639c3448"

# aks identity/rbac
aad_admin_group_object_ids = [
  "f350cc08-29aa-4f3b-92cf-259e16c082a6"
]
local_account_disabled = true


# grafana identity/rbac
aad_grafana_viewers_group_object_id = [
  "f350cc08-29aa-4f3b-92cf-259e16c082a6"
]
aad_grafana_editors_group_object_ids = [
  "f350cc08-29aa-4f3b-92cf-259e16c082a6"
]
