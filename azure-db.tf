resource "azurerm_mssql_server" "server_database" {
  name                         = format("azsdb-%s", var.PROJECT_NAME)
  resource_group_name          = azurerm_resource_group.rg_ptoject.name
  location                     = var.AZ_REGION
  version                      = "12.0"
  administrator_login          = var.AZURE_SERVER_DATABASE_USER
  administrator_login_password = var.AZURE_SERVER_DATABASE_PASSWORD
}

resource "azurerm_mssql_database" "mssql_database" {
  name           = format("azdb-%s", var.PROJECT_NAME)
  server_id      = azurerm_mssql_server.server_database.id
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  max_size_gb    = 200
  read_scale     = false
  sku_name       = "S0"
  zone_redundant = false
}