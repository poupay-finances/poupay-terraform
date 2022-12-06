resource "azurerm_resource_group" "rg_ptoject" {
  name     = format("azrg-%s", var.PROJECT_NAME)
  location = var.AZ_REGION
}

resource "azurerm_storage_account" "sa_project" {
  name                     = format("azsa%s", var.PROJECT_NAME)
  resource_group_name      = azurerm_resource_group.rg_ptoject.name
  location                 = var.AZ_REGION
  account_tier             = "Standard"
  account_replication_type = "LRS"
}