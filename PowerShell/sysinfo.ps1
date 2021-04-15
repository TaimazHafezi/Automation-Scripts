# Hardware Information Function
function HardwareInfo {
    "Hardware Description" 
    $hardwareinfo = Get-WmiObject -class win32_computersystem | 
        foreach {
            New-Object -TypeName psobject -Property @{
                Description = $_.description
                Manufacturer = $_.manufacturer
                Model = $_.model
                Name = $_.name
                PrimaryOwnerName=$_.primaryownername
                }
            } |
    Format-List  description,
        Manufacturer,
        Model,
        Name,
        PrimaryOwnerName
    $hardwareinfo
    }
    HardwareInfo
   
    # operating system information function
    function OSInfo {
    " Operating system name and version number"
    $OSInfo = Get-WmiObject -class win32_operatingsystem |
      foreach {
            New-Object -TypeName psobject -Property @{
                Name = $_.name
                version = $_.version
                }
            } |
        Format-List Name,
                    Version
        $OSInfo
        }
        OSInfo

# Processor description function

   function processorinfo {
    "Processor Description"
    $processorinfo = Get-WmiObject -class win32_processor |
        foreach {
            new-object -TypeName psobject -Property @{
                Description = switch ($_.description) {
                    $empty {
                        "Data Unavailable"
                        }
                    default {
                        $_
                        }
                    }
                numberofcores = switch ($_.NumberOfCores) {
                      $empty {
                      "Data Unavailable"
                      }
                      default {
                        $_
                        }
                    }
                L1CacheSize = switch ($_.L1CacheSize) {
                    $empty {
                        "Data Unavailable"
                        }
                    default {
                       $_.L1CacheSize/1mb
                       }
                   }  
                L2CacheSize = switch ($_.L2CacheSize) {
                    $empty {
                        "Data Unavailable"
                        }
                    default {b
                       $_.L2CacheSize/1mb
                       }
                   }            
                L3CacheSize = switch ($_.L3CacheSize) {
                    $empty {
                        "Data unavailable"
                        }
                     default {
                        $_.L3CacheSize/1mb
                        }
                    }
            }
        } |   
        Format-List Description, 
           numberofcores,
           L1CacheSize, 
           L2CacheSize, 
           L3CacheSize 
    $processorinfo
    }
    processorinfo

    # summary of the RAM function

    function summaryRAM {
    "Summary of RAM"
   # $totalCapacity = 0

    Get-WmiObject -class win32_physicalmemory |
        foreach {
            New-Object -TypeName psobject -Property @{
                Manufacturer = $_.manufacturer
                Description = $_.description
                "Capacity(MB)" = $_.capacity/1MB
                Bank = $_.banklabel
                Slot = $_.devicelocator
            }
        } |
        format-table -AutoSize Manufacturer,
                              Description,
                              "Capacity(MB)",
                               Bank,
                               Slot

    }
    summaryRAM
    
    # Summary of disk drives function
    function diskdrives {
    "Summary of disk drives"
    $diskdrives = get-ciminstance cim_diskdrive
    foreach ($disk in $diskdrives) {
        $partitions = $disk | Get-CimAssociatedInstance -resultclassname CIM_diskpartition
        foreach ($partition in $partitions) {
            $logicaldisks = $partition | Get-CimAssociatedInstance -ResultClassName CIM_logicaldisk
            foreach ($logicaldisk in $logicaldisks) {
                New-Object -TypeName psobject -property @{Manufacturer=$disk.Manufacturer
                                                          Location=$partition.deviceid
                                                          Drive=$logicaldisk.deviceid
                                                          "Size(GB)"=$logicaldisk.size / 1gb -as [int]
                                                          }
            }
        }
    }
    }
diskdrives
# Network Adapter Configuration report function
function networkadapter {
"Network adapter configuration report"
    Get-CimInstance Win32_NetworkAdapterConfiguration | Where-Object IPEnabled -eq "True" |
                                                          
                                                              Select-Object @{n="Description";e={$_.Description}},
                                                                            @{n="Index";e={$_.index}},
                                                                            @{n="IP Address(es)";e={$_.ipaddress}},
                                                                            @{n="Subnet Mask(s)";e={$_.Ipsubnet}},
                                                                            @{n="DNS Domain Name";e={$_.DNSHostname}},
                                                                            @{n="DNS Server";e={$_.DNSServerSearchOrder}} | format-table 
}

networkadapter

# Video card description function

function videocard {
" Video card description and Resolution"
$videocard = Get-WmiObject -class win32_videocontroller
$videocard | Format-List description, name
$vertical = ($videocard).currentverticalresolution
$Horizontal = ($videocard).currenthorizontalresolution
"Your screen resolution is $horizontal pixel in $vertical pixels"
}
videocard                                                       
     