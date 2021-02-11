$AllSubs = @(Get-AzSubscription | Select -ExpandProperty SubscriptionID)
foreach ($SubID in $AllSubs) {
Select-AzSubscription -SubscriptionID $SubID
Get-AzRoleAssignment -IncludeClassicAdministrators | Export-Csv .\Output.csv -Append
 }