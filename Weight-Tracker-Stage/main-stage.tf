#Creat A Resource Group For both environments
resource "azurerm_resource_group" "Weight-Tracker-App-stage" {
  name     = "Weight-Tracker-App-stage"
  location = "West us"
}

