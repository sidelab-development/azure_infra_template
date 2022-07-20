output "sample_storage_account" {
  value       = [for x in module.app_infra : x.sample_storage_account]
  description = "Name of the storage account that will be used for the sample"
}
output "sample_function_app" {
  value       = [for x in module.app_infra : x.sample_function_app]
  description = "Name of the function app that will be used for the sample microservice"
}
output "sample_cosmos_db_endpoint" {
  value       = [for x in module.app_infra : x.sample_cosmos_db_endpoint]
  description = "Sample CosmosDB endpoint"
}
output "sample_sql_db" {
  value       = [for x in module.app_infra : x.sample_sql_db]
  description = "Sample DB name"
}
output "sample_container" {
  value       = [for x in module.app_infra : x.sample_container]
  description = "Sample container name"
}
output "sample_sb_queue" {
  value       = [for x in module.app_infra : x.sample_sb_queue]
  description = "Name of the Service Bus Queue that will be used for the sample"
}
