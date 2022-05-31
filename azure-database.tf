resource "azurerm_resource_group" "rg_database" {
  name     = format("azrg-%s", var.projectName)
  location = var.azRegion
}

resource "azurerm_storage_account" "sa_database" {
  name                     = format("azsa%s", var.projectName)
  resource_group_name      = azurerm_resource_group.rg_database.name
  location                 = var.azRegion
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_mssql_server" "server_database" {
  name                         = format("azsdb-%s", var.projectName)
  resource_group_name          = azurerm_resource_group.rg_database.name
  location                     = var.azRegion
  version                      = "12.0"
  administrator_login          = "urubu100"
  administrator_login_password = "Urubu1@@"
}

resource "azurerm_mssql_database" "mssql_database" {
  name           = format("azdb-%s", var.projectName)
  server_id      = azurerm_mssql_server.server_database.id
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  max_size_gb    = 200
  read_scale     = false
  sku_name       = "S0"
  zone_redundant = false
}
