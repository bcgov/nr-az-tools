
resource "azurerm_resource_group" "rg" {
  location            = "canadacentral"
  name                = "aif1"
}

# Create subnet
resource "azapi_resource" "my_terraform_subnet" {
  name                 = "aif1-vm-subnet"
  type = "Microsoft.Network/virtualNetworks/subnets@2024-01-01"
  parent_id = var.vnetId
  locks = [
    var.vnetId
  ]
  body = {
      properties = {
        addressPrefix = var.spokeIp
        networkSecurityGroup = {
          id = azurerm_network_security_group.my_terraform_nsg.id
        }
      }
    }
    response_export_values = ["*"]
}

# Create Network Security Group and rule
resource "azurerm_network_security_group" "my_terraform_nsg" {
  name                = "aif1-vm-nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = var.spokeIp
    destination_address_prefix = "*"
  }
}

# Create network interface
resource "azurerm_network_interface" "my_terraform_nic" {
  name                = "aif1-vm-nic"
  location            = "canadacentral"
  resource_group_name = "aif1"
  ip_configuration {
    name                          = "my_nic_configuration"
    subnet_id                     = azapi_resource.my_terraform_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "example" {
  network_interface_id      = azurerm_network_interface.my_terraform_nic.id
  network_security_group_id = azurerm_network_security_group.my_terraform_nsg.id
}

# Create virtual machine
resource "azurerm_linux_virtual_machine" "my_terraform_vm" {
  name                  = "aif1-vm"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.my_terraform_nic.id]
  size                  = "Standard_B2s"
  
  os_disk {
    name                 = "myOsDisk"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  computer_name  = "hostname"
  admin_username = var.username

  admin_ssh_key {
    username   = var.username
    public_key = azapi_resource_action.ssh_public_key_gen.output.publicKey
  }

  boot_diagnostics {
    storage_account_uri = var.primary_blob_endpoint
  }
}