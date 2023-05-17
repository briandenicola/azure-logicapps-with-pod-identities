data "azurerm_managed_api" "this" {
  name     = "eventhubs"
  location = var.region
}

# resource "azurerm_api_connection" "this" {
#   name                = "${local.eventhub_name}-connection"
#   resource_group_name = azurerm_resource_group.this.name
#   managed_api_id      = data.azurerm_managed_api.this.id
#   display_name        = "${local.eventhub_name}-connection"

#   parameter_values = {
#     connection_string = "sb://${local.eventhub_name}.eventhub.windows.net/"
#   }

#   lifecycle {
#     ignore_changes = ["parameter_values"]
#   }
# }

resource "azurerm_resource_group_template_deployment" "managed_api_connection" {
  name                = "${local.eventhub_name}-connection"
  resource_group_name = azurerm_resource_group.this.name
  deployment_mode     = "Incremental"
  parameters_content = jsonencode({
    "connections_eventhub_name" = {
      value = "${local.eventhub_name}-connection"
    },
    "eventhub_name" = {
      value =  local.eventhub_name
    }
  })
  template_content = <<TEMPLATE
{
  "$schema": "https://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
      "connections_eventhub_name": {
          "type": "string"
      },
      "eventhub_name": {
          "type": "string"
      }
  },
  "variables": {},
  "resources": [
    {
      "type": "MICROSOFT.WEB/CONNECTIONS",
      "apiVersion": "2016-06-01",
      "name": "[parameters('connections_eventhub_name')]",
      "location": "[resourceGroup().location]",
      "kind": "V2",
      "properties": {
        "alternativeParameterValues": {},
        "displayName": "[parameters('connections_eventhub_name')]",
        "api": {
          "name": "eventhubs",
          "displayName": "Event Hubs",
          "id": "[concat(subscription().id, '/providers/Microsoft.Web/locations/', resourceGroup().location, '/managedApis/', 'eventhubs')]",
          "type": "Microsoft.Web/locations/managedApis"
        },
        "customParameterValues": {},
        "parameterValueSet": {
          "name": "managedIdentityAuth",
          "values": {
            "namespaceEndpoint": {
              "value": "[concat('sb://', parameters('eventhub_name'), '.eventhub.windows.net/')]"
            }
          }
        }
      }
    }
  ],
  "outputs": {
  }
}
TEMPLATE
}