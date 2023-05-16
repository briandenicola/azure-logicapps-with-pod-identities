output "RESOURCE_GROUP" {
  value     = azurerm_resource_group.this.name
  sensitive = false
}

output "MSI_NAME" {
  value     = azurerm_user_assigned_identity.aks_pod_identity.name
  sensitive = false
}