output "aks_name" {
  value = module.aks["dev"].aks_name
}

output "aks_fqdn" {
  value = module.aks["dev"].aks_fqdn
}

output "kube_config_raw" {
  value     = module.aks["dev"].kube_config_raw
  sensitive = true
}
