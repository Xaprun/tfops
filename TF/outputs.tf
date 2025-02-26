output "aks_name" {
  value = module.aks_spot.aks_name
}

output "kube_config" {
  value     = module.aks_spot.kube_config
  sensitive = true
}

output "aks_fqdn" {
  value = module.aks_spot.aks_fqdn
}
