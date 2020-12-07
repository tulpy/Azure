# Solution

Azure Firewall is a firewall-as-a-service solution existing in the Microsoft public cloud, that allows you to secure  resources in Azure Virtual Networks and govern network flows. This solution provides a mechanism designed to make a scheduled backup of the Azure Firewall configuration using Azure Automation.

## Scope

The scope of this focuses on backing up the Azure Firewall configuration using an Azure Auomtation account in azure.

## Pre-Requisites

* Azure Automation Account
* Storge Account

### Azure Automation

An Azure Automation Account will be used with the following settings defined.

* Runbook - backupAzFwToBlobStorage.ps1
* Modules - Az.Accounts, Az.Network, AzResources
* Schedule - 8pm Daily
* Authentication - RunAs Account
* Parameters
  * StorageAccountName = ""
  * ResourceGroupName = ""
  * BlobContainerName = ""
  * StorageKey = ""
  * RetentionDays = ""
  * AzureFirewallName = ""

### Azure Storage Account

An Azure Storage Account will be used for this with the following settings defined.

* Container - ""
* filenames - ""
* Account Kind - StorageV2
* Performance - Standard
* Secure Transfer - Enabled
* Tier - Hot
* Replication - LRS