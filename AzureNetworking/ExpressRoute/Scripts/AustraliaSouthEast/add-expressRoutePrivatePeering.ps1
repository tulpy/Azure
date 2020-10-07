<#
.VERSION 1.0
.AUTHOR stephen.tulp@insight.com
.COMPANYNAME Insight

.RELEASENOTES
June 08, 2020 1.0   
    - Initial script

  .DESCRIPTION
    This script configures the ExpressRoute circuit for Private Peering (RT-MEL-COR-ERC-001)
#>

$ckt = Get-AzExpressRouteCircuit -Name "RT-MEL-COR-ERC-001" -ResourceGroupName "RT-AU-COR-ARG-Network"
$parameters = @{
    Name = "AzurePrivatePeering"
    ExpressRouteCircuit = $ckt
    PeeringType = "AzurePrivatePeering"
    PeerASN = "4200003051"
    PrimaryPeerAddressPrefix = "10.194.201.20/30"
    SecondaryPeerAddressPrefix = "10.194.201.24/30"
    VlanId  = "1337"
}
Add-AzExpressRouteCircuitPeeringConfig @parameters
Set-AzExpressRouteCircuit -ExpressRouteCircuit $ckt