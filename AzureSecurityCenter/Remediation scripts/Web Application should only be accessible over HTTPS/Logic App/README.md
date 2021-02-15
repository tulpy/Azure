# Logic Apps sample playbook to remediate
This sample playbook allows you to remediate Web Application instances that do not have HTTPS enabled according to ASC's recommendation *"Web Application should only be accessible over HTTPS"*

**Post deployment steps**<br>
* The playbook leverages a "Managed Identity" which needs to be configured after deployment. This "Managed Identity" also requires the appropriete permissions for the resources that you would like to remediate
* A schedule has been configured to run each month, modify this according your need


<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2FAzure-Security-Center%2Fmaster%2FSecure%2520Score%2FWeb%2520Application%2520should%2520only%2520be%2520accessible%2520over%2520HTTPS%2FLogic%2520App%2Fazuredeploy.json" target="_blank">
    <img src="http://azuredeploy.net/deploybutton.png"/>
</a>

