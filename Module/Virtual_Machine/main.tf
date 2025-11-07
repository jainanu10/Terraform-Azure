resource "azurerm_resource_group" "rg" {
    name = var.name
    location = var.location
}
resource "azurerm_virtual_network" "vn" {
    name = "virtual-network"
    location = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    address_space = ["10.0.0.0/16"]
}
resource "azurerm_subnet" "sn" {
    name = "azure-subnet"
    resource_group_name =  azurerm_resource_group.rg.name
    virtual_network_name = azurerm_virtual_network.vn.name 
    address_prefixes = ["10.0.0.0/8"]
}
