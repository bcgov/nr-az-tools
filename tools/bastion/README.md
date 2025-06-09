# How to use this module

> [!IMPORTANT]
> these are very experimental terraform scripts and not recomended for production use
> The Virtual Network (VNET) should be the **_existing_** VNet within the Subscription that was created as part of your Project Set (ie. `abc123-dev-vwan-spoke`). The subnet will be created within this VNet.

## Usage

You must update the values in the `provider.tf` file, specifically the **backend** configuration.

```terraform
backend "azurerm" {
  resource_group_name  = "tfstate"
  storage_account_name = "tfstate"
  container_name       = "tfstate"
  key                  = "terraform.tfstate"
}
```

Create `example.auto.tfvars` file.

```terraform
virtual_network_name           = "abc-test-vwan-spoke"
virtual_network_resource_group = "abc-test-networking"
virtual_network_id             = "/subscriptions/def/resourceGroups/d94cca-test-networking/providers/Microsoft.Network/virtualNetworks/d94cca-test-vwan-spoke"

resource_group_name        = "abc" # eg: 'abc'
bastion_host_name          = "bastion" # NOTE: Will be appended with a random string
location                   = "canadacentral"
bastionSubnetAddressPrefix = "<ip address range for subnet>" # eg: "10.46.61.128/26"

sku                = "Developer"
copy_paste_enabled = true # Configuration: Copy and paste
```
