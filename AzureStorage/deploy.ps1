<#
.VERSION 1.0
.AUTHOR stephen.tulp@insight.com
.COMPANYNAME Insight

.RELEASENOTES
December 24, 2020 1.0   
    - Initial script

   .SYNOPSIS
    Deploy Azure storage account
  .DESCRIPTION
    This script deploys an Azure storage account into a resource group
  .PARAMETER ResourceGroupName
    The Resource Group where the Azure storage account will be provisioned into
  .PARAMETER TemplateFile
    The Azure storage account ARM template.
  .PARAMETER TemplateParameterFile
    The parameter file for Azure storage accounts
  .EXAMPLE
    ./New-AzResourceGroupDeployment -ResourceGroupName "" -TemplateFile "" -TemplateParameterFile ""

#>

# Parameters
$TemplateFile = ".\azuredeploy.json"
$TemplateParameterFile = ".\parameters\azuredeploy.parameters.json"
$RG = "scg-npe-arg-network"

New-AzResourceGroupDeployment -ResourceGroupName $RG -TemplateFile $TemplateFile -TemplateParameterFile $TemplateParameterFile