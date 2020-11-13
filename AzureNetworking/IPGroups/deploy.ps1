<#
.VERSION 1.0
.AUTHOR stephen.tulp@insight.com
.COMPANYNAME Insight

.RELEASENOTES
October 09, 2020 1.0   
    - Initial script

   .SYNOPSIS
    Deploy IP Groups
  .DESCRIPTION
    This script deploys ARM templates for IP Groups into a resource group
  .PARAMETER ResourceGroupName
    The Resource Group where the resources will be provisioned too
  .PARAMETER TemplateFile
    The IP Groups ARM template
  .PARAMETER TemplateParameterFile
    The parameter files for the IP Groups
  .EXAMPLE
    ./New-AzResourceGroupDeployment -ResourceGroupName "" -TemplateFile "" -TemplateParameterFile ""

#>

# Parameters
$TemplateFile = ".\azuredeploy.json"
$TemplateParameterFile = ".\parameters\azuredeploy.parameters.json"
$RG = "HO-RG-Networking-Core"

New-AzResourceGroupDeployment -ResourceGroupName $RG -TemplateFile $TemplateFile -TemplateParameterFile $TemplateParameterFile