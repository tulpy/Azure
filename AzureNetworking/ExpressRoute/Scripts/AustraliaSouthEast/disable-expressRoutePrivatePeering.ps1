<#
.VERSION 1.0
.AUTHOR stephen.tulp@insight.com
.COMPANYNAME Insight

.RELEASENOTES
June 08, 2020 1.0    
    - Initial script

  .DESCRIPTION
    This script disables Private Peering within an ExpressRoute Circuit
#>

# Parameters
$ExpressRouteCircuitName = ""
$ExpressRouteCircuitRG = ""

$ckt = Get-AzExpressRouteCircuit -Name $ExpressRouteCircuitName -ResourceGroupName $ExpressRouteCircuitRG

$ckt.Peerings[0].State = "Disabled"

Set-AzExpressRouteCircuit -ExpressRouteCircuit $ckt