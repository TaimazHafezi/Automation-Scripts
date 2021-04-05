Get-CimInstance Win32_NetworkAdapterConfiguration | where IPEnabled -EQ "True" | Format-Table Description, Index, IPAddress, IPSubnet, DNSDomain, DNSHostName
