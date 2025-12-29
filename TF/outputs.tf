output "aks_name" {
  value = module.aks[0].aks_name
}

output "aks_fqdn" {
  value = module.aks[0].aks_fqdn
}

output "kube_config_raw" {
  value     = module.aks[0].kube_config_raw
  sensitive = true
}
