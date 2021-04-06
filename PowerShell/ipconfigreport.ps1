Get-CimInstance Win32_NetworkAdapterConfiguration | Where-Object IPEnabled -Match "True" |
                                                          
                                                          Select-Object @{n="Description";e={$_.Description}},
                                                                        @{n="Index";e={$_.index}},
                                                                        @{n="IP Address(es)";e={$_.ipaddress}},
                                                                        @{n="Subnet Mask(s)";e={$_.Ipsubnet}},
                                                                        @{n="DNS Domain Name";e={$_.DNSHostname}},
                                                                        @{n="DNS Server";e={$_.DNSServerSearchOrder}} | format-table 
                                                            