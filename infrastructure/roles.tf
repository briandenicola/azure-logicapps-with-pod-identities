resource "azurerm_role_assignment" "blob" {
  scope                = azurerm_storage_account.this.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azurerm_user_assigned_identity.aks_pod_identity.principal_id
  skip_service_principal_aad_check = true  
}

resource "azurerm_role_assignment" "hub" {
  scope                = azurerm_eventhub_namespace.this.id
  role_definition_name = "Azure Event Hubs Data Owner"
  principal_id         = azurerm_user_assigned_identity.aks_pod_identity.principal_id
  skip_service_principal_aad_check = true  
}