data "azurerm_managed_api" "this" {
  name     = "eventhubs"
  location = var.region
}

resource "azurerm_api_connection" "this" {
  name                = "${local.eventhub_name}-connection"
  resource_group_name = azurerm_resource_group.this.name
  managed_api_id      = data.azurerm_managed_api.this.id
  display_name        = "${local.eventhub_name}-connection"

  parameter_values = {
    connectionString = azurerm_eventhub_namespace.this.default_primary_connection_string
  }
}