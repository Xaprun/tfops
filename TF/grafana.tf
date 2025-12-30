# Azure Managed Grafana
locals {
  tags_common = merge(
    var.tags,
    {
      Environment = var.environment
      Module      = "grafana"
    }
  )
}



resource "azurerm_dashboard_grafana" "this" {
  name                = var.grafana_name
  location            = var.location
  resource_group_name = var.resource_group_name

  grafana_major_version = 10

  identity {
    type = "SystemAssigned"
  }

  tags = local.tags_common
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
