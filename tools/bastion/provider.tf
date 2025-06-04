terraform {
  required_version = ">= 1.9.0"

  backend "azurerm" {
    resource_group_name  = "aif1"
    storage_account_name = "aif1"
    container_name       = "aif1-bastion"
    key                  = "terraform.tfsate"
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }

    azapi = {
      source  = "Azure/azapi"
      version = "~> 2.0"
    }
  }
}

provider "azurerm" {
  use_oidc = true
  features {
    # NOTE: This is required because we have the Azure Monitor Baseline Alerts policies in place,
    # which auto-create metric alerts for specific resources types within the Resource Group where the resource is created.
    # The AMBA metic alerts prevent the deletion of the Resource Group, as they are not created by this module.
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
  # subscription_id is now required with AzureRM provider 4.0. Use either of the following methods:
  subscription_id = "32abe758-215c-4136-95fa-5f1f3963eee6"
  # export ARM_SUBSCRIPTION_ID=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
}

provider "azapi" {}
