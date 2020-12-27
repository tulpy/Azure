$subs = Get-AzSubscription

$tagname = "CreatedDate"
$tagvalue = "test"

$subs | ForEach-Object {
    Set-AzContext $_
    $rs = Get-AzResource -TagName $tagname -TagValue $tagvalue
    $rs | ForEach-Object {
        $_.Tags.Remove($tagname)
        $_ | Set-AzResource -Force
    }  
}