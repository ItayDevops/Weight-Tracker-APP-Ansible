resource "azurerm_availability_set" "avset" {
   name                         = "avset"
   location                     = azurerm_resource_group.Weight-Tracker-App.location
   resource_group_name          = azurerm_resource_group.Weight-Tracker-App.name
 }
######Managed-Db-Postgres-prod########
resource "azurerm_postgresql_server" "VM-DB-SERVER" {
  name                = "postgres-sql-db"
  location            = azurerm_resource_group.Weight-Tracker-App.location
  resource_group_name = azurerm_resource_group.Weight-Tracker-App.name

  administrator_login          = var.db-user
  administrator_login_password = var.db-password

  sku_name   = "GP_Gen5_2"
  version    = "11"
  storage_mb = 65536

  backup_retention_days        = 7
  geo_redundant_backup_enabled = true
  auto_grow_enabled            = true

  public_network_access_enabled    = false
  ssl_enforcement_enabled          = true
  ssl_minimal_tls_version_enforced = "TLS1_2"
}
 


 ######App-SERVER-DEPLOYMENT########
 resource "azurerm_virtual_machine" "VM-APP-SERVER" {
   count                 = 3
   name                  = "VM-APP-SERVER${count.index}"
   location              = azurerm_resource_group.Weight-Tracker-App.location
   availability_set_id   = azurerm_availability_set.avset.id
   resource_group_name   = azurerm_resource_group.Weight-Tracker-App.name
   #network_interface_ids = [azurerm_network_interface.VM-APP-NIC[count.index].id]
   network_interface_ids =[element(azurerm_network_interface.VM-APP-NIC.*.id, count.index)]
   vm_size               = "Standard_DS1_v2"



   storage_image_reference {
    offer     = "0001-com-ubuntu-server-focal"
    publisher = "Canonical"
    sku       = "20_04-lts"
    version   = "latest"
   }

   storage_os_disk {
     name              = "APPsDisk${count.index}"
     caching           = "ReadWrite"
     create_option     = "FromImage"
     managed_disk_type = "Standard_LRS"
   }


   os_profile {
     computer_name  = "VM-APP-SERVER"
     admin_username = var.app-user
     admin_password = var.app-password
   }

   os_profile_linux_config {
     disable_password_authentication = false
   }

 }
 resource "azurerm_managed_disk" "VM-APP-SERVER-DISK" {
  name                 = "VM-APP-SERVER-DISK" 
  location             = azurerm_resource_group.Weight-Tracker-App.location
  resource_group_name  = azurerm_resource_group.Weight-Tracker-App.name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = "70"
 }