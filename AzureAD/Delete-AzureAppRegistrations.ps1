<#
.VERSION 1.0
.AUTHOR stephen.tulp@insight.com
.COMPANYNAME Insight

.RELEASENOTES
August 4, 2020 1.0   
    - Initial script

   .SYNOPSIS
    Delete all App Registrations in a subscription.
  .DESCRIPTION
    This script delete all App Registrations in a subscription.
#>

# Get all App registrations
$AppRegIds = (Get-AzADApplication).ObjectId

# Loop through the results
For ($i=0; $i -lt $AppRegIds.Length; $i++) 
  {
   Remove-AzADApplication -objectid $AppRegIds[$i]
  }