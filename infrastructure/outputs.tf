output "RESOURCE_GROUP" {
  value     = azurerm_resource_group.this.name
  sensitive = false
}

output "MSI_NAME" {
  value     = azurerm_user_assigned_identity.aks_pod_identity.name
  sensitive = false
}

output "MSI_CLIENT_ID" {
  value     = azurerm_user_assigned_identity.aks_pod_identity.client_id
  sensitive = false
}

output "MSI_TENANT_ID" {
  value     = azurerm_user_assigned_identity.aks_pod_identity.tenant_id
  sensitive = false
}

output "MSI_SUBSCRIPTION_ID" {
  value     = data.azurerm_client_config.current.subscription_id
  sensitive = false
}

output "STORAGE_ACCOUNT_NAME" {
  value     = azurerm_storage_account.this.name
  sensitive = false
}

output "LOCATION" {
  value = var.region
  sensitive = false
}

output "APP_NAME" {
  value = local.resource_name
  sensitive = false
}

output "EVENTHUB_NAMESPACE_NAME" {
  value = azurerm_eventhub_namespace.this.name
  sensitive = false
}