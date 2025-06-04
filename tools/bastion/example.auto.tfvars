virtual_network_name           = "d94cca-test-vwan-spoke"
virtual_network_resource_group = "d94cca-test-networking"
virtual_network_id             = "/subscriptions/32abe758-215c-4136-95fa-5f1f3963eee6/resourceGroups/d94cca-test-networking/providers/Microsoft.Network/virtualNetworks/d94cca-test-vwan-spoke"

resource_group_name        = "aif1"
bastion_host_name          = "bastion" # NOTE: Will be appended with a random string
location                   = "canadacentral"
bastionSubnetAddressPrefix = "10.46.61.0/24"

sku                = "Developer"
copy_paste_enabled = true # Configuration: Copy and paste

### Standard / Premium features:
# file_copy_enabled = true # Configuration: File transfer using a native client
# ip_connect_enabled = true # Configuration: IP-based connection
# kerberos_enabled = true # Configuration: Kerberos authentication
# scale_units = 4 # Configuration: Instance count
# shareable_link_enabled = true # Configuration: Shareable Link
# tunneling_enabled = true # Configuration: Native client support
# session_recording_enabled = true # Configuration: Session recording (Preview)
