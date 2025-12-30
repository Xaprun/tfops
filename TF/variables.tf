#################################
# Global
#################################

variable "location" {
  type    = string
  default = "North Europe"
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "tags" {
  type    = map(string)
  default = {}
}

#################################
# Resource Group
#################################

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group for AKS and supporting resources"
}

#################################
# Networking (owned by root)
#################################

variable "vnet_name" {
  type = string
}

variable "subnet_name" {
  type = string
}

variable "vnet_cidr" {
  type    = string
  default = "10.10.0.0/16"
}

variable "subnet_cidr" {
  type    = string
  default = "10.10.1.0/24"
}

variable "dns_service_ip" {
  type    = string
  default = "10.1.0.10"
}

variable "service_cidr" {
  type    = string
  default = "10.1.0.0/16"
}

variable "network_policy" {
  type    = string
  default = "azure"
}

#################################
# AKS Core
#################################

variable "aks_cluster_name" {
  type = string
}

variable "dns_prefix" {
  type    = string
  default = null
}

variable "kubernetes_version" {
  type    = string
  default = null
}

variable "private_cluster_enabled" {
  type    = bool
  default = false
}

#################################
# API access
#################################

variable "api_server_authorized_ip_ranges" {
  type    = list(string)
  default = null
  description = "Public IP/CIDR allowed to access AKS API (null = unrestricted)"
}

#################################
# Identity / RBAC
#################################

variable "tenant_id" {
  type    = string
  default = null
}

variable "aad_admin_group_object_ids" {
  type    = list(string)
  default = null
}

variable "local_account_disabled" {
  type    = bool
  default = false
}

variable "aks_ci_sp_object_id" {
  type        = string
  description = "Object ID of CI Service Principal used for AKS access"
}

#################################
# System Node Pool
#################################

variable "system_node_pool_name" {
  type    = string
  default = "system"
}

variable "node_count" {
  type    = number
  default = 1
}

variable "node_vm_size" {
  type    = string
  default = "Standard_DS2_v2"
}

variable "system_max_pods" {
  type    = number
  default = 110
}

#################################
# Additional Node Pool
#################################

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

variable "additional_pool_node_count" {
  type    = number
  default = 1
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

variable "additional_pool_max_pods" {
  type    = number
  default = 110
}

variable "additional_pool_spot_max_price" {
  type    = number
  default = -1
}

#################################
# Observability
#################################

variable "enable_oms_agent" {
  type    = bool
  default = true
}

variable "enable_managed_prometheus" {
  type    = bool
  default = true
}
