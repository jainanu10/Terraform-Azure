resource "azurerm_resource_group" "rg" {
    name = var.name
    location = var.location
}

resource "azurerm_network_security_group" "example_nsg" {
  name                = "example-nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "Allow-RDP"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389" # RDP port
    source_address_prefix      = "Internet" # Or specific IP/CIDR
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow-SSH"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22" # SSH port
    source_address_prefix      = "Internet"
    destination_address_prefix = "*"
  }
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

resource "azurerm_network_interface" "example_nic" {
  name                = "example-nic"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.example_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "example_vm" {
  name                = "example-vm"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.name
  size                = "Standard_DS1_v2"
  admin_username      = "azureadmin"
  admin_password      = "P@$$w0rd1234!" # Replace with a strong password or use a variable
  network_interface_ids = [azurerm_network_interface.example_nic.id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
}