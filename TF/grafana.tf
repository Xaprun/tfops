# -----------------------------
# Azure Managed Grafana (ROOT)
# -----------------------------



locals {
  grafana_name_final = coalesce(var.grafana_name, "${var.aks_cluster_name}-grafana")

  grafana_tags = merge(var.tags, {
    Environment = var.environment
    Module      = "grafana"
  })
}

# (Opcjonalnie, ale pomaga gdy subskrypcja nie ma zarejestrowanego RP)
# Jeśli nie chcesz dotykać rejestracji z TF – zrób to w pipeline az CLI.
resource "azurerm_resource_provider_registration" "dashboard" {
  count = var.enable_managed_grafana ? 1 : 0
  name  = "Microsoft.Dashboard"
}

# (BARDZO praktyczne) odczekaj chwilę po utworzeniu RG – usuwa 404 na świeżym RG
resource "time_sleep" "wait_for_rg" {
  count           = var.enable_managed_grafana ? 1 : 0
  create_duration = "30s"

  depends_on = [azurerm_resource_group.rg]
}

resource "azurerm_dashboard_grafana" "this" {
  count = var.enable_managed_grafana ? 1 : 0

  name                = local.grafana_name_final
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  grafana_major_version = 10

  identity {
    type = "SystemAssigned"
  }

  tags = local.grafana_tags

  depends_on = [
    time_sleep.wait_for_rg,
    azurerm_resource_provider_registration.dashboard
  ]
}

# RBAC – REQUIRED
resource "azurerm_role_assignment" "grafana_monitor_reader" {
  count = var.enable_managed_grafana ? 1 : 0

  # Jeśli chcesz żeby Grafana czytała metryki z klastra / Azure Monitor:
  # scope = data.azurerm_subscription.current.id  # szeroko
  scope                = module.aks.aks_id        # węziej (tylko AKS)
  role_definition_name = "Monitoring Reader"
  principal_id         = azurerm_dashboard_grafana.this[0].identity[0].principal_id

  depends_on = [azurerm_dashboard_grafana.this]
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

output "grafana_id" {
  description = "Grafana resource ID"
  value       = var.enable_managed_grafana ? azurerm_dashboard_grafana.this[0].id : null
}
