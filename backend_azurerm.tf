terraform {
  backend "azurerm" {
    # The resource group which contains the storage account used for state
    resource_group_name  = var.backend_resource_group_name

    # The storage account name (must be globally unique)
    storage_account_name = var.backend_storage_account_name

    # The container inside the storage account to store the state
    container_name       = var.backend_container_name

    # The state file name (you can change per-environment)
    key                  = var.backend_key

    # Optional: enable if you want Terraform to use Azure AD auth (managed identity / Azure CLI)
    # use_azuread_auth = true
  }
}

# Note: define the variables referenced above (e.g. in variables.tf or via -var / environment variables).
# Example variable definitions you can add to `variables.tf`:
#
# variable "backend_resource_group_name" {
#   description = "Resource group where the backend storage account exists"
# }
#
# variable "backend_storage_account_name" {
#   description = "Storage account name for tfstate (must be lowercase and globally unique)"
# }
#
# variable "backend_container_name" {
#   description = "Blob container name for storing tfstate"
#   default     = "tfstate"
# }
#
# variable "backend_key" {
#   description = "Path/filename inside the container for this Terraform state"
#   default     = "terraform.tfstate"
# }
#
# After creating the storage account & container and setting variables, run:
#
#   terraform init
#
# Authentication: Terraform will authenticate to Azure using the normal AzureRM provider methods
# (Azure CLI `az login`, environment variables ARM_CLIENT_ID/ARM_CLIENT_SECRET/ARM_TENANT_ID, or managed identity).
