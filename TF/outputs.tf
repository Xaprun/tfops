output "aks_name" {
  value = module.aks.aks_name
}

output "aks_fqdn" {
  value = module.aks.aks_fqdn
}

output "kube_config_raw" {
  value     = module.aks.kube_config_raw
  sensitive = true
}
