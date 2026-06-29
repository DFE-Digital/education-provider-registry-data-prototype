data "azurerm_key_vault" "eprweb" {
  name                = local.other_service_keyvault_name
  resource_group_name = local.other_service_resource_group_name
}

resource "azurerm_key_vault_secret" "eprweb_eprdat_dotnet_db_connection" {
  name         = "eprweb-eprdat-dotnet-db-connection"
  value        = module.postgres.dotnet_connection_string
  key_vault_id = data.azurerm_key_vault.eprweb.id
}

locals {
  name_suffix         = "app"
  other_service_short = "eprweb"
  name_prefix         = "${var.azure_resource_prefix}-${local.other_service_short}-${var.config_short}"

  other_service_keyvault_name       = "${local.name_prefix}-${local.name_suffix}-kv"
  other_service_resource_group_name = "${local.name_prefix}-rg"
}
