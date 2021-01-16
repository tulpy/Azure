<#
.VERSION 1.0
.AUTHOR stephen.tulp@insight.com
.COMPANYNAME Insight

.RELEASENOTES
January 16, 2021 1.0   
    - Initial script

   .SYNOPSIS
    Remove Azure File Sync solution
  .DESCRIPTION
    This script removes Azure File Sync
  .PARAMETER ResourceGroupName
    The Resource Group where Azure File Sync is deployed
  .PARAMETER TemplateFile
    The Azure File Sync template

  .EXAMPLE
    ./New-AzResourceGroupDeployment -ResourceGroupName "" -TemplateFile "" -TemplateParameterFile ""

#>

# Parameters
$RG = "stt-syd-cor-arg-afs"

Remove-AzResourceGroup -Force -Name $RG