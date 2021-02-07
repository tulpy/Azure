$azsubs = Get-AzSubscription

$azPolicy = @()

foreach ($azsub in $azsubs) {
    Set-AzContext $azsub.id | Out-Null
    
    
    $nonCompliantResources = Get-AzPolicyState | Where-Object { $_.ComplianceState -eq "NonCompliant" -and $_.PolicyDefinitionAction -eq "deployIfNotExists"}

    Foreach ($resource in $nonCompliantResources) {
        $resourceName = $resource.resourceId.Split('/')[-1]
        $resourceType = $resource.resourceType
        $complianceState = $resource.complianceState
        $resourceGroup = $resource.resourceGroup
        $resourceLocation = $resource.resourceLocation
        $azPolicy += @($("Resource Name: " + $resourceName), ("Resource Type: " + $resourceType), `
                        ("Compliance State: " + $complianceState), ("Resource Group: " + $resourceGroup), `
                        ("Resource Location: " + $resourceLocation), ("Subscription Name: " + $azsub.Name))
           
                        $azPolicy += @(" ")

    }

    $azsubName = $azsub.Name
    $azPolicy > .\$azsubName.txt
}