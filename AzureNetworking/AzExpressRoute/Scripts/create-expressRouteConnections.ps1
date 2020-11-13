<#
.VERSION 1.0
.AUTHOR stephen.tulp@insight.com
.COMPANYNAME Insight

.RELEASENOTES
June 08, 2020 1.0   
    - Initial script

  .DESCRIPTION
    This script creates an ExpressRoute Connection between the ExpressRoute circuit and the ExpressRoute Gateway
#>

# Parameters
$ExpressRouteCircuitName = ""
$ExpressRouteCircuitRG = ""

# Create the ExpressRoute Connection from the ExpressRoute Circuit to the Primary ExpressRoute Gateway

$circuit = Get-AzExpressRouteCircuit -Name "RT-MEL-COR-ERC-001" -ResourceGroupName "RT-AU-COR-ARG-Network"
$gw = Get-AzVirtualNetworkGateway -Name "RT-SYD-COR-VNG-002" -ResourceGroupName "RT-AU-COR-ARG-Network"
New-AzVirtualNetworkGatewayConnection -Name "RT-MEL-COR-ERC-001-to-RT-SYD-COR-VNG-002" -ResourceGroupName "RT-AU-COR-ARG-Network" -Location "Australia East" -VirtualNetworkGateway1 $gw -PeerId $circuit.Id -ConnectionType ExpressRoute  -RoutingWeight "80"

Get-AzVirtualNetworkGatewayConnection -Name "RT-MEL-COR-ERC-001-to-RT-SYD-COR-VNG-002" -ResourceGroupName "RT-AU-COR-ARG-Network"

# Create the ExpressRoute Connection from the ExpressRoute Circuit to the Primary ExpressRoute Gateway

$circuit = Get-AzExpressRouteCircuit -Name "RT-MEL-COR-ERC-001" -ResourceGroupName "RT-AU-COR-ARG-Network"
$gw = Get-AzVirtualNetworkGateway -Name "RT-MEL-COR-VNG-002" -ResourceGroupName "RT-AU-COR-ARG-Network"
New-AzVirtualNetworkGatewayConnection -Name "RT-MEL-COR-ERC-001-to-RT-MEL-COR-VNG-002"  -ResourceGroupName "RT-AU-COR-ARG-Network" -Location "Australia SouthEast" -VirtualNetworkGateway1 $gw -PeerId $circuit.Id -ConnectionType ExpressRoute -RoutingWeight "100"

Get-AzVirtualNetworkGatewayConnection -Name "RT-MEL-COR-ERC-001-to-RT-MEL-COR-VNG-002" -ResourceGroupName "RT-AU-COR-ARG-Network"