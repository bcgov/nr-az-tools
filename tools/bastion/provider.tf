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
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
  # subscription_id is now required with AzureRM provider 4.0. Use either of the following methods:
  # subscription_id="xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
  # export ARM_SUBSCRIPTION_ID=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
}

provider "azapi" {}
