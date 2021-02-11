<#
.VERSION 1.0
.AUTHOR stephen.tulp@insight.com
.COMPANYNAME Insight

.RELEASENOTES
Feb 11, 2021 1.0   
    - Initial script

  .DESCRIPTION
    This script exports all Azure RBAC permissions to a .csv
#>

$AllSubs = @(Get-AzSubscription | Select-Object -ExpandProperty SubscriptionID)
foreach ($SubID in $AllSubs) {
    Select-AzSubscription -SubscriptionID $SubID
    Get-AzRoleAssignment -IncludeClassicAdministrators | Export-Csv .\AzureRbacPermissions.csv -Append
}