# azure-file-sync

Demonstration of how Azure File Sync can be configured to synchronize files in multiple locations.

![Final Environment](https://user-images.githubusercontent.com/3911650/49400286-0a9eb000-f701-11e8-95f9-4ff38170319c.png)

## Getting Started

An Azure RM template is included in `infrastructure/` to create the environment:

<a href="http://armviz.io/#/?load=https%3A%2F%2Fraw.githubusercontent.com%2Flrakai%2Fazure-file-sync%2Fmaster%2Finfrastructure%2Farm-template.json">
    <img src="https://camo.githubusercontent.com/536ab4f9bc823c2e0ce72fb610aafda57d8c6c12/687474703a2f2f61726d76697a2e696f2f76697375616c697a65627574746f6e2e706e67" data-canonical-src="http://armviz.io/visualizebutton.png" style="max-width:100%;">
</a> 

Using Azure PowerShell, do the following to provision the resources:

```ps1
.\New-Lab.ps1
```

Alternatively, you can perform a one-click deploy with the following button:

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Flrakai%2Fazure-file-sync%2Fmaster%2Finfrastructure%2Farm-template.json">
    <img src="https://camo.githubusercontent.com/9285dd3998997a0835869065bb15e5d500475034/687474703a2f2f617a7572656465706c6f792e6e65742f6465706c6f79627574746f6e2e706e67" data-canonical-src="http://azuredeploy.net/deploybutton.png" style="max-width:100%;">
</a>

## Following Along

1. Create a Storage Sync Service.

2. Create a file share in the storage account created in the ARM template.

3. Create a sync group in the Storage Sync Service using the file share as the cloud endpoint.

4. Install the File Sync Agent of both VMs (it is automatically downloaded to `C:\Agents`).

5. Add server endpoints in the sync gorup for both VMs.

6. Experiment with adding files to the configured server endpoints.

## Tearing Down

When finished, remove the Azure resources with:
```ps1
.\Remove-Lab.ps1
```
