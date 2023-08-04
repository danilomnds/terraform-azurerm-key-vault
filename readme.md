# Module - Azure Key Vault
[![COE](https://img.shields.io/badge/Created%20By-CCoE-blue)]()
[![HCL](https://img.shields.io/badge/language-HCL-blueviolet)](https://www.terraform.io/)
[![Azure](https://img.shields.io/badge/provider-Azure-blue)](https://registry.terraform.io/providers/hashicorp/azurerm/latest)

Module developed to standardize the Azure Key Vault creation.

## Compatibility Matrix

| Module Version | Terraform Version | AzureRM Version |
|----------------|-------------------| --------------- |
| v1.0.0         | v1.5.4            | 3.67.0          |

## Specifying a version

To avoid that your code get updates automatically, is mandatory to set the version using the `source` option. 
By defining the `?ref=***` in the the URL, you can define the version of the module.

Note: The `?ref=***` refers a tag on the git module repo.

## Important note

This module grantees the role "Reader" for the azure AD groups listed using the var azure_ad_groups.

For example, to grant read access on secrets for an Azure AD group you should specify the var access_policy like in the example below.

## Use case

```hcl
module "<kv-system-env-001>" {
  source = "git::https://github.com/danilomnds/terraform-azurerm-key-vault?ref=v1.0.0" 
  name = "<kv-system-env-001>"
  location = "<your-region>"
  resource_group_name = "<resource-group>"
  sku_name = "<standard|premium>"
  azure_ad_groups = ["group id 1","group id 2"]
  tenant_id = "<your tenant id>"
  access_policy = [
    {
      # all permissions for a group should be in the same block
      tenant_id = "<your tenant id>"
      object_id = "<your object 1>"
      secret_permissions = ["Backup","Delete","Get","List","Purge","Recover","Restore","Set"]
      key_permissions = ["Backup","Delete","Get","List","Purge","Recover","Restore","Set"]
    },
    {
      tenant_id = "<your tenant id>"
      object_id = "<your object 2>"
      key_permissions = ["Backup","Delete","Get","List","Purge","Recover","Restore","Set"]
    }
  ]
  tags = {
    key1 = "value1"
    key2 = "value2"    
  }  
}
output "kv-system-env-001-name" {
  value = module.<kv-system-env-001>.name
}
output "kv-system-env-001-id" {
  value = module.<kv-system-env-001>.id
}
```

## Input variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | logic app name | `string` | n/a | `Yes` |
| location | azure region | `string` | n/a | `Yes` |
| resource_group_name | resource group name where the resource(s) will be created | `string` | n/a | `Yes` |
| sku_name | the name of the sku used for this key vault | `string` | n/a | `Yes` |
| tenant_id | the azure active directory tenant id that should be used for authenticating requests to the key vault | `string` | n/a | `Yes` |
| access_policy | block as defined below | `list(object(map{}))` | `[{}]` | No |
| enabled_for_deployment | boolean flag to specify whether azure virtual machines are permitted to retrieve certificates stored as secrets from the key vault | `bool` | `false` | No |
| enabled_for_disk_encryption | boolean flag to specify whether azure disk encryption is permitted to retrieve secrets from the vault and unwrap keys | `bool` | `false` | No |
| enabled_for_template_deployment | boolean flag to specify whether azure resource manager is permitted to retrieve secrets from the key vault | `bool` | `false` | No |
| enable_rbac_authorization | boolean flag to specify whether azure key vault uses role based access control (rbac) for authorization of data actions | `bool` | `false` | No |
| network_acls | block as defined below | `object(map{})` | `{}` | No |
| purge_protection_enabled | is purge protection enabled for this key vault | `bool` | `false` | No |
| public_network_access_enabled | whether public network access is allowed for this key vault | `bool` | `true` | No |
| soft_delete_retention_days | the number of days that items should be retained for once soft-deleted | `number` | `90` | No |
| contact | block as defined below | `object(map{})` | `{}` | No |
| tags | tags for the resource | `map(string)` | `{}` | No |
| azure_ad_groups | list of azure AD groups that will be granted the Application Insights Component Contributor role  | `list` | `[]` | No |

# Objects. List of acceptable parameters
| Variable Name (Block) | Parameter | Description | Type | Default | Required |
|-----------------------|-----------|-------------|------|---------|:--------:|
| access_policy | tenant_id | the azure active directory tenant id that should be used for authenticating requests to the key vault | `string` | `null` | `Yes` |
| access_policy | object_id | the object id of a user, service principal or security group in the azure active directory tenant for the vault | `string` | `null` | `Yes` |
| access_policy | application_id | the object id of an application in azure active directory | `string` | `null` | No |
| access_policy | certificate_permissions | list of certificate permissions | `list(string)` | `null` | No |
| access_policy | key_permissions | list of key permissions | `list(string)` | `null` | No |
| access_policy | secret_permissions | list of secret permissions | `list(string)` | `null` | No |
| access_policy | storage_permissions | list of storage permissions | `list(string)` | `null` | No |
| network_acls | bypass | list of storage permissions | `string` | `null` | `Yes` |
| network_acls | default_action | the default action to use when no rules match from ip_rules / virtual_network_subnet_ids | `string` | `null` | `Yes` |
| network_acls | ip_rules | one or more ip addresses, or cidr blocks which should be able to access the key vault | `list(string)` | `null` | No |
| network_acls | virtual_network_subnet_ids | one or more subnet ids which should be able to access this key vault | `list(string)` | `null` | No |
| contact | email | e-mail address of the contact | `string` | `null` | `Yes` |
| contact | name | name of the contact | `string` | `null` | No |
| contact | phone | phone number of the contact | `string` | `null` | No |


## Output variables

| Name | Description |
|------|-------------|
| name | Key Vault name |
| id | Key Vault id |

## Documentation

Terraform Key Vault: <br>
[https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault)<br>