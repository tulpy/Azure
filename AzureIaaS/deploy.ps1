<#
.VERSION 1.0
.AUTHOR stephen.tulp@insight.com
.COMPANYNAME Insight

.RELEASENOTES
December 23, 2020 1.0   
    - Initial script

   .SYNOPSIS
    Deploy Azure IaaS VM
  .DESCRIPTION
    This script deploys ARM templates for an Azure IaaS VM
  .PARAMETER ResourceGroupName
    The Resource Group where the Azure IaaS VM will be provisioned into
  .PARAMETER TemplateFile
    The Azure IaaS VM template
  .PARAMETER TemplateParameterFile
    The parameter files for the Azure IaaS VM
  .EXAMPLE
    ./New-AzResourceGroupDeployment -ResourceGroupName "" -TemplateFile "" -TemplateParameterFile ""

#>

###################################################
#   Azure DevOps Self Build Agent VMs
###################################################

# Parameters
$RG = "dwer-syd-npe-arg-integrationvm"
$TemplateFile = ".\azuredeploy.json"
$TemplateParameterFile = ".\parameters\azuredeploy.parameters.json"
$SubId = "8d0248a2-d875-4407-99a6-0981fe09bff2"

# Connect to Subscription
#Connect-AzAccount -SubscriptionId $SubId

# Run deployment
New-AzResourceGroupDeployment -ResourceGroupName $RG -TemplateFile $TemplateFile -TemplateParameterFile $TemplateParameterFile

