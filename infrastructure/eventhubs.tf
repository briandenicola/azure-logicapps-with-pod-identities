resource "azurerm_eventhub_namespace" "this" {
  name                         = local.eventhub_name
  resource_group_name          = azurerm_resource_group.this.name
  location                     = azurerm_resource_group.this.location
  sku                          = "Standard"
  maximum_throughput_units     = 5
  auto_inflate_enabled         = true
  local_authentication_enabled = false
}

resource "azurerm_eventhub" "this" {
  name                = "requests"
  namespace_name      = azurerm_eventhub_namespace.this.name
  resource_group_name = azurerm_resource_group.this.name
  partition_count     = 15
  message_retention   = 7
}

resource "azurerm_eventhub_consumer_group" "this" {
  name                = "logicapp-client"
  namespace_name      = azurerm_eventhub_namespace.this.name
  eventhub_name       = azurerm_eventhub.this.name
  resource_group_name = azurerm_resource_group.this.name
}
