# How to use this module

> [!NOTE]
> these are very experimental terraform scripts and not recomended for production use
> This module creates a Linux VM, its own subnet (within the spoke vnet), and connectivity.

## Prerequisites

To use this module, it is required to have the following:

- A Virtual Network (VNET)
- Subscription ID for the `hashicorp/azurerm` provider (required when using v4.x)
- a Bastion instance through which we will connect to this VM

## Usage

create a `variables.tf` file:

```terraform
variable "subnetId" {
  default     = "< ID of AzureBastionSubnet subnet>"
}

variable spokeIp {
  type        = string
  description = "The IP address of the Bastion host that will be used to connect to the VM."
  default     = "<IP address>" # eg: "10.46.61.0/26"
}

variable primary_blob_endpoint {
  type        = string
  description = "The primary blob endpoint for the storage account."
  default     = "https://aif1.blob.core.windows.net/"
}

variable "vnetId" {
  type        = string
  description = "The ID of the virtual network where the VM will be deployed."
  default     = "<vnet ID>"
}

variable "username" {
  type        = string
  description = "The username for the local account that will be created on the new VM."
  default     = "azureadmin"
}
```