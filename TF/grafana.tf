# Azure Managed Grafana
resource "azurerm_dashboard_grafana" "this" {
  name                = coalesce(var.grafana_name, "${var.aks_cluster_name}-grafana")
  resource_group_name = var.resource_group_name
  location            = var.location

  identity {
    type = "SystemAssigned"
  }
}

# RBAC dla Grafany (MUSI BYĆ)
resource "azurerm_role_assignment" "grafana_monitor_reader" {
  scope                = data.azurerm_subscription.current.id
  role_definition_name = "Monitoring Reader"
  principal_id         = azurerm_dashboard_grafana.this.identity[0].principal_id
}

variable "enable_managed_grafana" {
  type    = bool
  default = true
}

variable "grafana_name" {
  type    = string
  default = null
}

output "grafana_url" {
  description = "Public URL of Azure Managed Grafana"
  value       = azurerm_dashboard_grafana.this.endpoint
}
