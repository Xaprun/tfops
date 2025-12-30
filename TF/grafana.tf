# -----------------------------
# Azure Managed Grafana (ROOT)
# -----------------------------

locals {
  grafana_name_final = coalesce(
    var.grafana_name,
    "${var.aks_cluster_name}-grafana"
  )

  grafana_tags = merge(
    var.tags,
    {
      Environment = var.environment
      Module      = "grafana"
    }
  )
}

data "azurerm_subscription" "current" {}

resource "azurerm_dashboard_grafana" "this" {
  count               = var.enable_managed_grafana ? 1 : 0
  name                = local.grafana_name_final
  location            = var.location
  resource_group_name = var.resource_group_name

  grafana_major_version = 10

  identity {
    type = "SystemAssigned"
  }

  tags = local.grafana_tags
}

# RBAC – REQUIRED
resource "azurerm_role_assignment" "grafana_monitor_reader" {
  count                = var.enable_managed_grafana ? 1 : 0
  scope                = data.azurerm_subscription.current.id
  role_definition_name = "Monitoring Reader"
  principal_id         = azurerm_dashboard_grafana.this[0].identity[0].principal_id
}

# -----------------------------
# Variables
# -----------------------------

variable "enable_managed_grafana" {
  description = "Enable Azure Managed Grafana"
  type        = bool
  default     = true
}

variable "grafana_name" {
  description = "Optional custom name for Grafana"
  type        = string
  default     = null
}

# -----------------------------
# Outputs
# -----------------------------

output "grafana_url" {
  description = "Public URL of Azure Managed Grafana"
  value       = var.enable_managed_grafana ? azurerm_dashboard_grafana.this[0].endpoint : null
}
