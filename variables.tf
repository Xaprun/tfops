variable "aks_cluster_name" {
  description = "Nazwa klastra AKS"
  type        = string
}

variable "location" {
  description = "Region Azure"
  type        = string
}

variable "resource_group_name" {
  description = "Nazwa grupy zasobów"
  type        = string
}

variable "node_count" {
  description = "Liczba węzłów w puli domyślnej"
  type        = number
  default     = 1
}

variable "node_vm_size" {
  description = "Rozmiar VM w puli domyślnej"
  type        = string
  default     = "Standard_DS2_v2"
}

variable "enable_additional_pool" {
  description = "Czy włączyć dodatkową pulę"
  type        = bool
  default     = false
}

variable "additional_pool_mode" {
  description = "Tryb dodatkowej puli: Standard lub Spot"
  type        = string
  default     = "Standard"
}

variable "additional_pool_name" {
  description = "Nazwa dodatkowej puli"
  type        = string
  default     = "extra"
}

variable "additional_pool_vm_size" {
  description = "Rozmiar VM w dodatkowej puli"
  type        = string
  default     = "Standard_DS2_v2"
}

variable "additional_pool_node_count" {
  description = "Liczba węzłów w dodatkowej puli"
  type        = number
  default     = 2
}

variable "additional_pool_min_count" {
  description = "Minimalna liczba węzłów (auto-scaling)"
  type        = number
  default     = 1
}

variable "additional_pool_max_count" {
  description = "Maksymalna liczba węzłów (auto-scaling)"
  type        = number
  default     = 5
}
