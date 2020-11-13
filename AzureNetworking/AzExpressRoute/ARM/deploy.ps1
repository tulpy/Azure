<#
.VERSION 1.0
.AUTHOR stephen.tulp@insight.com
.COMPANYNAME Insight

.RELEASENOTES
February 26, 2020 1.0   
    - Initial script
June 08, 2020 1.1   
    - Added 2nd circuit

   .SYNOPSIS
    Deploy ExpressRoute circuits into Azure
  .DESCRIPTION
    This script deploys ARM templates for ExpressRoute into a resource group
  .PARAMETER ResourceGroupName
    The Resource Group where the ExpressRoute Circuit will be provisioned into
  .PARAMETER TemplateFile
    The ExpressRoute ARM template, this will be generic across all ExpressRoute circuits
  .PARAMETER TemplateParameterFile
    The parameter files for each ExpressRoute circuit, named accordingly
  .EXAMPLE
    ./New-AzResourceGroupDeployment -ResourceGroupName "" -TemplateFile "" -TemplateParameterFile ""

#>

# Parameters
$TemplateParameterFile = ".\parameters\azuredeploy.parameters.json"
$RG = ""

New-AzResourceGroupDeployment -ResourceGroupName $RG -TemplateFile ".\azuredeploy.json" -TemplateParameterFile $TemplateParameterFile