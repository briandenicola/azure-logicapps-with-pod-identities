resource "azurerm_user_assigned_identity" "aks_pod_identity" {
  name                = "${local.resource_name}-${var.namespace}-identity"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
}