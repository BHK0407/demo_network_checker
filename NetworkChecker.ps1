# Function to check IP address configuration
function CheckIPAddress {
    $ipConfig = Get-NetIPAddress | Where-Object { $_.InterfaceAlias -eq 'Ethernet' }

    if ($ipConfig) {
        Write-Host "IPv4 Address: $($ipConfig.IPAddress)"
        Write-Host "Subnet Mask: $($ipConfig.PrefixLength)"
        $defaultGateway = (Get-NetRoute | Where-Object { $_.DestinationPrefix -eq '0.0.0.0/0' }).NextHop
        if ($defaultGateway) {
            Write-Host "Default Gateway: $defaultGateway"
        }
        else {
            Write-Host "Default Gateway: Not Configured"
        }
    }
    else {
        Write-Host "No IP configuration found for Ethernet interface."
    }
    
}

# Function to check DNS server configuration
function CheckDNSServers {
    $dnsConfig = Get-DnsClientServerAddress -AddressFamily IPv4

    if ($dnsConfig) {
        Write-Host "DNS Server:"
        $dnsConfig.ServerAddresses | ForEach-Object {
            Write-Host $_
        }
    }
    else {
        Write-Host "DNS server configuration not found."
    }
}

# Function to check network configuration
function CheckNetworkConfiguration {
    Write-Host "Checking network configuration..."
    CheckIPAddress
    CheckDNSServers
}

# Main script
CheckNetworkConfiguration
