
# Outputs
output "storage_account_id" {
  description = "ID du storage account"
  value       = azurerm_storage_account.main.id
}

output "storage_account_name" {
  description = "Nom du storage account"
  value       = azurerm_storage_account.main.name
}

output "primary_access_key" {
  description = "Clé d'accès primaire"
  value       = azurerm_storage_account.main.primary_access_key
  sensitive   = true
}

output "primary_blob_endpoint" {
  description = "Endpoint Blob primaire"
  value       = azurerm_storage_account.main.primary_blob_endpoint
}