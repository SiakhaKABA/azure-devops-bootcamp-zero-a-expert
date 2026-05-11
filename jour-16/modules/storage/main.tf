# modules/storage/main.tf

locals {
  # Nom unique généré automatiquement
  storage_account_name = coalesce(
    var.storage_account_name_override,
    substr(
      replace("st${var.project_name}${var.environment}${random_string.suffix.result}", "-", ""),
      0,
      24
    )
  )
  
  # Tags fusionnés
  merged_tags = merge({
    Environment = var.environment
    ManagedBy   = "Terraform"
    Module      = "storage"
    ModuleVersion = "1.0.0"
  }, var.tags)
}

resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
  numeric = true
}

# Storage Account principal
resource "azurerm_storage_account" "main" {
  name                     = local.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
  min_tls_version          = var.min_tls_version
  https_traffic_only_enabled = true
  
  blob_properties {
    delete_retention_policy {
      days = var.soft_delete_retention_days
    }
    versioning_enabled = var.environment == "prod" ? true : false
  }
  
  tags = local.merged_tags
}

# Conteneurs Blob
resource "azurerm_storage_container" "containers" {
  for_each = var.containers
  
  name                  = each.key
  storage_account_id    = azurerm_storage_account.main.id
  container_access_type = each.value.access_type
}
