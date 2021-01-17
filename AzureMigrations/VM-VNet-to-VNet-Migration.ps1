# Needed Parameters for the script
Param
(
    [Parameter(Mandatory=$True, HelpMessage="Enter the Resource Group of the original VM")]
    [string] $OriginalResourceGroup,
    [Parameter(Mandatory=$True, HelpMessage="Enter the original VM name")]
    [string] $OriginalvmName,
    [Parameter(Mandatory=$True, HelpMessage="Enter the new VM name")]
    [string] $NewvmName,
    [Parameter(Mandatory=$True, HelpMessage="Enter the new availability set name")]
    [string] $NewAvailSetName,
    [Parameter(Mandatory=$True, HelpMessage="Enter the new VNet resource group")]
    [string] $NewVnetResourceGroup,
    [Parameter(Mandatory=$True, HelpMessage="Enter the new VNet name")]
    [string] $NewVNetName,
    [Parameter(Mandatory=$True, HelpMessage="Enter the new Subnet name")]
    [string] $NewSubnet,
    [Parameter(Mandatory=$True, HelpMessage="Enter Azure region")]
    [string] $Location
)

<#
    .SYNOPSIS
        Migrates an Azure VM from current VNet to a new VNet in Azure by creating a new VM in new VNet retaining the original VMs configuration and data disks.
    .DESCRIPTION
        Steps in move VM to new VNet: 
            (1) Gathers info on existing VM, VNet, and subnet.
            (2) Removes the original VM while saving all data disks and VM info.
            (3) Creates VM configuration for new VM, creates nic for new VM, and new availability set.  
            (4) Adds data disks to new VM, adds nics to new VM, adds VM to the new VNet.
            (5) Creates new VM and adds the VM to the new VNet.
        
        ***NOTE***
        The line starting with Set-AzVMOSDisk be sure to set -Linux or -Windows depending on VM OS of the original VM at the end of the line before running this script.
    
    .PARAMETER OriginalResourceGroup
        Resource Group of the original VM
    .PARAMETER OriginalvmName
        Original VM name
    .PARAMETER NewvmName
        New VM name
    .PARAMETER NewAvailSetName
        New availability set name
    .PARAMETER NewVnetResourceGroup
        New VNet resource group
    .PARAMETER NewVNetName
        New VNet name
    .PARAMETER NewSubnet
        New Subnet name
    .PARAMETER Location
        Azure region
    .EXAMPLE
      OriginalresourceGroup: RG01
      OriginalvmName: VM01
      NewvmName: VM02
      NewAvailSetName: AS02
      NewVnetResourceGroup: RG02
      NewVNetName: VNETB
      NewSubnet: Subnet1
      Location: $Location
    
    .NOTES
        Name: Vnet-to-Vnet VM migration.ps1  
        Version:       1.0
        Author:        Microsoft MVP - Steve Buchanan (www.buchatech.com)
        Creation Date: 8-21-2019
        Edits:         
    .PREREQUISITES
        PowerShell version: 5 or 7
        Modules:         For PowerShell 5 use AzureRM Module. For PowerShell 7 (Core) use AZ module.
#>

Write-Host "Log into Azure Services..."
#Azure Account Login
try {
                Connect-AzAccount -ErrorAction Stop
}
catch {
                # The exception lands in [Microsoft.Azure.Commands.Common.Authentication.AadAuthenticationCanceledException]
                Write-Host "User Cancelled The Authentication" -ForegroundColor Yellow
                exit
}

#Print list of Azure subscriptions
Get-AzSubscription 

# Set Azure Subscription ID Variable
$selectedSubscriptionID = Read-Host ' If you have multple Azure Subscriptions. Enter Azure subscription ID you want to use.'

# Set Azure subscription
Set-AzContext -SubscriptionId $selectedSubscriptionID -ErrorAction Ignore

#Get info for the VNet and subnet
    $NewVnet = Get-AzVirtualNetwork -Name $NewVNetName -ResourceGroupName $NewVnetResourceGroup
    $backEndSubnet = $NewVnet.Subnets|Where-Object{$_.Name -eq $NewSubnet}
    
#Get the details of the VM to be moved
    $originalVM = Get-AzVM -ResourceGroupName $OriginalResourceGroup -Name $OriginalvmName

#Remove the original VM
    Remove-AzVM -ResourceGroupName $OriginalResourceGroup -Name $OriginalvmName    

#Create new availability set if it does not exist

    $availSet = Get-AzAvailabilitySet -ResourceGroupName $NewVnetResourceGroup -Name $NewAvailSetName -ErrorAction Ignore
    if (-Not $availSet) {$availSet = New-AzAvailabilitySet -Location "$Location" -Name $NewAvailSetName -ResourceGroupName $NewVnetResourceGroup -PlatformFaultDomainCount 2 -PlatformUpdateDomainCount 2 -Sku Aligned}

#Create the basic configuration for the new VM
    $newVM = New-AzVMConfig -VMName $NewvmName -VMSize $originalVM.HardwareProfile.VmSize -AvailabilitySetId $availSet.Id
        
#***NOTE*** Use -Linux or -Windows at the end of this line.
 Set-AzVMOSDisk -VM $newVM -CreateOption Attach -ManagedDiskId $originalVM.StorageProfile.OsDisk.ManagedDisk.Id -Name $originalVM.StorageProfile.OsDisk.Name -Windows

#Create new NIC for new VM
    New-AzNetworkInterface -ResourceGroupName $NewVnetResourceGroup `
      -Name "01$NewvmName" `
      -Location "$Location" `
      -SubnetId $backEndSubnet.Id

#Add Data Disks
    foreach ($disk in $originalVM.StorageProfile.DataDisks) { Add-AzVMDataDisk -VM $newVM -Name $disk.Name -ManagedDiskId $disk.ManagedDisk.Id -Caching $disk.Caching -Lun $disk.Lun -DiskSizeInGB $disk.DiskSizeGB -CreateOption Attach
    }

#Add NIC(s)
    $nicId = (Get-AzNetworkInterface -ResourceGroupName "$NewVnetResourceGroup" -Name "01$NewvmName").Id
    foreach ($nic in $originalVM.NetworkProfile.NetworkInterfaces) {Add-AzVMNetworkInterface -VM $newVM -Id $nicId}

#Recreate the VM
    New-AzVM -ResourceGroupName $NewVnetResourceGroup -Location $originalVM.Location -VM $newVM -Verbose

