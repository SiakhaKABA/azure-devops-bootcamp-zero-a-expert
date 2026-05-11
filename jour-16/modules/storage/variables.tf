# modules/storage/variables.tf
# ============================================
# PARAMÈTRES OBLIGATOIRES
# ============================================

variable "project_name" {
  description = "Nom du projet pour les noms des ressources"
  type        = string
  
  validation {
    condition     = can(regex("^[a-z0-9]{3,20}$", var.project_name))
    error_message = "Le nom du projet doit contenir 3-20 caractères alphanumériques minuscules."
  }
}

variable "environment" {
  description = "Environnement cible"
  type        = string
  
  validation {
    condition     = contains(["dev", "staging", "prod", "mgmt"], var.environment)
    error_message = "Environment doit être dev, staging, prod ou mgmt."
  }
}

variable "resource_group_name" {
  description = "Nom du groupe de ressources existant"
  type        = string
}

variable "location" {
  description = "Région Azure"
  type        = string
}

# ============================================
# PARAMÈTRES DE STORAGE ACCOUNT
# ============================================

variable "storage_account_name_override" {
  description = "Override le nom du storage account (si non fourni, généré automatiquement)"
  type        = string
  default     = null
  
  validation {
    condition     = var.storage_account_name_override == null ? true : can(regex("^[a-z0-9]{3,24}$", var.storage_account_name_override))
    error_message = "Le nom du storage account doit faire 3-24 caractères alphanumériques minuscules."
  }
}

variable "account_tier" {
  description = "Tier du compte de stockage"
  type        = string
  default     = "Standard"
  
  validation {
    condition     = contains(["Standard", "Premium"], var.account_tier)
    error_message = "Account tier doit être Standard ou Premium."
  }
}

variable "account_replication_type" {
  description = "Type de réplication"
  type        = string
  default     = "LRS"
  
  validation {
    condition     = contains(["LRS", "ZRS", "GRS", "GZRS", "RAGRS", "RAGZRS"], var.account_replication_type)
    error_message = "Type de réplication non supporté."
  }
}

variable "min_tls_version" {
  type        = string
  description = "Version TLS minimale"
  default     = "TLS1_2"
  
  validation {
    condition     = contains(["TLS1_2", "TLS1_3"], var.min_tls_version)
    error_message = "TLS version must be TLS1_2 or TLS1_3."
  }
}

variable "containers" {
  description = "Conteneurs Blob à créer"
  type = map(object({
    access_type = optional(string, "private")
  }))
  default = {}
}

variable "soft_delete_retention_days" {
  type        = number
  description = "Jours de rétention suppression réversible"
  default     = 7
  validation {
    condition     = var.soft_delete_retention_days >= 1 && var.soft_delete_retention_days <= 365
    error_message = "Doit être entre 1 et 365 jours."
  }
}

variable "tags" {
  type        = map(string)
  description = "Tags à appliquer"
  default     = {}
}