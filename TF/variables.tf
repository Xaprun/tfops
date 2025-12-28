variable "location" {
  type    = string
  default = "North Europe"
}

variable "resource_group_name" {
  type = string
}

variable "aks_cluster_name" {
  type = string
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "tags" {
  type    = map(string)
  default = {}
}

# Networking
variable "vnet_name"   { type = string }
variable "subnet_name" { type = string }

variable "vnet_cidr" {
  type    = string
  default = "10.10.0.0/16"
}

variable "subnet_cidr" {
  type    = string
  default = "10.10.1.0/24"
}

# AKS sizing
variable "node_count" {
  type    = number
  default = 1
}

variable "node_vm_size" {
  type    = string
  default = "Standard_DS2_v2"
}

# Uwaga: to ma być PUBLICZNY CIDR/IP Twojego klienta, nie prywatne 10.x/192.168.x.
# null = brak ograniczenia. (Najbezpieczniej na start: null)
variable "api_server_authorized_ip_ranges" {
  type    = list(string)
  default = null
}

# Monitoring
variable "enable_oms_agent" {
  type    = bool
  default = true
}

# Extra pool
variable "enable_additional_pool" {
  type    = bool
  default = false
}

variable "additional_pool_mode" {
  type    = string
  default = "Standard"
}

variable "additional_pool_name" {
  type    = string
  default = "extra"
}

variable "additional_pool_vm_size" {
  type    = string
  default = "Standard_DS2_v2"
}

variable "additional_pool_enable_auto_scaling" {
  type    = bool
  default = true
}

variable "additional_pool_min_count" {
  type    = number
  default = 1
}

variable "additional_pool_max_count" {
  type    = number
  default = 5
}
# fix warnings
variable "tenant_id" {
  type        = string
  description = "Tenant ID for AKS AAD integration"
  default     = null
}

variable "local_account_disabled" {
  type        = bool
  description = "Disable local AKS admin account"
  default     = false
}

variable "aad_admin_group_object_ids" {
  type        = list(string)
  description = "AAD group object IDs for AKS admins"
  default     = null
}


