resource "azurerm_storage_container" "container" {
  name                  = "examplecontainer"
  storage_account_name  = azurerm_storage_account.sa_project.name
  container_access_type = "private"
}

resource "azurerm_eventhub_namespace" "example" {
  name                = "example-namespace"
  resource_group_name = azurerm_resource_group.rg_project.name
  location            = azurerm_resource_group.rg_project.location
  sku                 = "Basic"
}

resource "azurerm_eventhub" "example" {
  name                = "example-eventhub"
  resource_group_name = azurerm_resource_group.rg_project.name
  namespace_name      = azurerm_eventhub_namespace.example.name
  partition_count     = 2
  message_retention   = 1
}

resource "azurerm_eventhub_authorization_rule" "example" {
  resource_group_name = azurerm_resource_group.rg_project.name
  namespace_name      = azurerm_eventhub_namespace.example.name
  eventhub_name       = azurerm_eventhub.example.name
  name                = "acctest"
  send                = true
}

resource "azurerm_iothub" "iot_hub" {
  name                          = "Example-IoTHub"
  resource_group_name           = azurerm_resource_group.rg_project.name
  location                      = azurerm_resource_group.rg_project.location
  public_network_access_enabled = true

  sku {
    name     = "F1"
    capacity = "1"
  }

  endpoint {
    type                       = "AzureIotHub.StorageContainer"
    connection_string          = azurerm_storage_account.sa_project.primary_blob_connection_string
    name                       = "export"
    batch_frequency_in_seconds = 60
    max_chunk_size_in_bytes    = 10485760
    container_name             = azurerm_storage_container.example.name
    encoding                   = "Avro"
    file_name_format           = "{iothub}/{partition}_{YYYY}_{MM}_{DD}_{HH}_{mm}"
  }

  route {
    name           = "export"
    source         = "DeviceMessages"
    condition      = "true"
    endpoint_names = ["export"]
    enabled        = true
  }
}

resource "azurerm_logic_app_workflow" "example" {
  name                = "workflow1"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_stream_analytics_job" "saj" {
  name                 = "sajexample"
  resource_group_name  = azurerm_resource_group.example.name
  location             = azurerm_resource_group.example.location
  compatibility_level  = "1.2"
  data_locale          = "en-US"
  streaming_units      = 1
  type                 = "Cloud"
  transformation_query = <<QUERY
        SELECT *
        INTO [YourOutputAlias]
        FROM [YourInputAlias]
    QUERY
}

resource "azurerm_stream_analytics_job" "saj_project" {
  name                = format("azsaj-%s", var.PROJECT_NAME)
  resource_group_name = azurerm_resource_group.rg_project.name
  location            = azurerm_resource_group.rg_project.location
  compatibility_level = "1.2"
  data_locale         = "en-US"
  streaming_units     = 1
  type                = "cloud"

  transformation_query = <<QUERY
        SELECT *
        INTO [YourOutputAlias]
        FROM [YourInputAlias]
    QUERY
}