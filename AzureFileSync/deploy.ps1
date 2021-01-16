<#
.VERSION 1.0
.AUTHOR stephen.tulp@insight.com
.COMPANYNAME Insight

.RELEASENOTES
January 16, 2021 1.0   
    - Initial script

   .SYNOPSIS
    Deploy Azure File Sync solution
  .DESCRIPTION
    This script deploys ARM templates for Azure File Sync
  .PARAMETER ResourceGroupName
    The Resource Group where Azure File Sync will be deployed into
  .PARAMETER TemplateFile
    The Azure File Sync template

  .EXAMPLE
    ./New-AzResourceGroupDeployment -ResourceGroupName "" -TemplateFile "" -TemplateParameterFile ""

#>

# Parameters
$TemplateFile = ".\template\azuredeploy.json"
$Region = "australiaeast"
$RG = "stt-syd-cor-arg-afs"

# Connect to Subscription
Connect-AzAccount
Select-AzSubscription -SubscriptionId "afa561b9-1bcc-4e69-bb33-af606363a7df"

New-AzResourceGroup -Name $RG -Location $Region
New-AzResourceGroupDeployment -ResourceGroupName $RG -TemplateFile $TemplateFile