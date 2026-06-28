module "migrations_job_configuration" {
  source = "./vendor/modules/aks//aks/application_configuration"

  namespace              = var.namespace
  environment            = local.app_name_suffix
  azure_resource_prefix  = var.azure_resource_prefix
  service_short          = var.service_short_name
  config_short           = var.environment_short_name
  secret_key_vault_short = "inf"

  config_variables = {
    ENVIRONMENT_NAME = var.environment_name
  }
  secret_variables = {
    CONNECTION_STRING = "${module.postgres.dotnet_connection_string};Command Timeout=0"
  }
}

module "migrations" {
  source = "./vendor/modules/aks//aks/job_configuration"

  namespace    = var.namespace
  environment  = var.environment
  service_name = var.service_name
  docker_image = var.docker_image
  commands     = ["/Apps/efbundle"]
  arguments    = ["--connection", "$(CONNECTION_STRING)"]
  job_name     = "migrations"
  enable_logit = var.enable_logit

  config_map_ref = module.migrations_job_configuration.kubernetes_config_map_name
  secret_ref     = module.migrations_job_configuration.kubernetes_secret_name
  cpu            = module.cluster_data.configuration_map.cpu_min
}
/*
.net
https://github.com/DFE-Digital/teaching-record-system/blob/ff709b65afb34d1f6c0f25ce282da75a4550aba3/terraform/aks/app.tf#L19

Rails
https://github.com/DFE-Digital/get-into-teaching-app/blob/a0a69dd2751bbc6bd82a29cb715fb6c995376954/terraform/aks/application.tf#L43
https://github.com/DFE-Digital/teaching-record-system/blob/ff709b65afb34d1f6c0f25ce282da75a4550aba3/terraform/aks/app.tf#L20
*/
