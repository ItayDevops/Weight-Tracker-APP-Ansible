#Creat A Resource Group For both environments
resource "azurerm_resource_group" "Weight-Tracker-App" {
  name     = "Weight-Tracker-App"
  location = "West us"
}

