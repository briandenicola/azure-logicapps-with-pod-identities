resource "azurerm_role_assignment" "blob" {
  scope                = azurerm_storage_account.this.id
  role_definition_name = "Storage Queue Data Contributor"
  principal_id         = azurerm_user_assigned_identity.aks_pod_identity.principal_id
  skip_service_principal_aad_check = true  
}

resource "azurerm_role_assignment" "queue" {
  scope                = azurerm_storage_account.this.id
  role_definition_name = "Storage Account Contributor"
  principal_id         = azurerm_user_assigned_identity.aks_pod_identity.principal_id
  skip_service_principal_aad_check = true  
}

resource "azurerm_role_assignment" "table" {
  scope                = azurerm_storage_account.this.id
  role_definition_name = "Storage Blob Data Owner"
  principal_id         = azurerm_user_assigned_identity.aks_pod_identity.principal_id
  skip_service_principal_aad_check = true  
}

resource "azurerm_role_assignment" "hub" {
  scope                = azurerm_eventhub_namespace.this.id
  role_definition_name = "Azure Event Hubs Data Owner"
  principal_id         = azurerm_user_assigned_identity.aks_pod_identity.principal_id
  skip_service_principal_aad_check = true  
}