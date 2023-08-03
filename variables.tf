variable "name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "sku_name" {
  type = string
}

variable "tenant_id" {
  type = string
}

variable "access_policy" {
  type = list(object({
    tenant_id               = string
    object_id               = string
    application_id          = optional(string)
    certificate_permissions = optional(list(string))
    key_permissions         = optional(list(string))
    secret_permissions      = optional(list(string))
    storage_permissions     = optional(list(string))
  }))
  default = []
}

/* double check do valor padrão
variable "enabled_for_deployment" {
  type = bool
  default = false
}

variable "enabled_for_disk_encryption " {
  type = bool
  default = false
}


variable "enabled_for_template_deployment" {
  type = bool
  default = false
}

variable "enable_rbac_authorization" {
  type = bool
  default = false
}
*/

variable "network_acls" {
  type = object({
    bypass                     = string
    default_action             = string
    ip_rules                   = optional(list(string))
    virtual_network_subnet_ids = optional(list(string))
  })
  default = null
}

/* verificar o padrão
variable "purge_protection_enabled" {
  type = bool
  default = false
}
*/

variable "public_network_access_enabled" {
  type    = bool
  default = true
}

/* verificar o padrão
variable "soft_delete_retention_days" {
  type = number
  default = null
}*/

variable "contact" {
  type = object({
    email = string
    name  = optional(string)
    phone = optional(string)
  })
  default = null
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "azure_ad_groups" {
  type    = list(string)
  default = []
}