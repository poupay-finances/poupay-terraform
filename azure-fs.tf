resource "azurerm_storage_share" "safs_desestruturados" {
  name                 = module.bucket_desestruturados.id
  storage_account_name = azurerm_storage_account.sa_project.name
  quota                = 100
  access_tier          = "TransactionOptimized"
}

resource "azurerm_storage_share" "safs_semi_estruturados" {
  name                 = module.bucket_semi_estruturados.id
  storage_account_name = azurerm_storage_account.sa_project.name
  quota                = 100
  access_tier          = "TransactionOptimized"
}

resource "azurerm_storage_share" "safs_estruturados" {
  name                 = module.bucket_estruturados.id
  storage_account_name = azurerm_storage_account.sa_project.name
  quota                = 100
  access_tier          = "TransactionOptimized"
}