output "AKS_RESOURCE_GROUP" {
  value     = azurerm_resource_group.this.name
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

output "ACR_NAME" {
  value     = azurerm_container_registry.this.name
  sensitive = false
}

output "AKS_CLUSTER_NAME" {
  value     = azurerm_kubernetes_cluster.this.name
  sensitive = false
}

output "APP_IDENTITY_NAME" {
  value     = azurerm_user_assigned_identity.aks_pod_identity.name
  sensitive = false
}

output "ARM_WORKLOAD_APP_ID" {
  value     = azurerm_user_assigned_identity.aks_pod_identity.client_id
  sensitive = false
}

output "ARM_WORKLOAD_RESOURCE_ID" {
  value     = azurerm_user_assigned_identity.aks_pod_identity.id
  sensitive = false
}

output "ARM_TENANT_ID" {
  value     = azurerm_user_assigned_identity.aks_pod_identity.tenant_id
  sensitive = false
}

output "ARM_SUBSCRIPTION_ID" {
  value     = data.azurerm_client_config.current.subscription_id
  sensitive = false
}

output "WEBJOB_STORAGE_ACCOUNT_NAME" {
  value     = azurerm_storage_account.this.name
  sensitive = false
}

output "NAMESPACE" {
  value = var.namespace
  sensitive = false
}

output "APPLICATIONINSIGHTS_CONNECTION_STRING" {
  value = azurerm_application_insights.this.connection_string
  sensitive = true
}