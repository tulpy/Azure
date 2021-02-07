# Reliability

Implementing reliable applications and services in Azure means they have to be both resilient and highly available. To achieve these goals, there are many decisions and tradeoffs that have to be made. The questions and initiatives below are based on the [Reliability pillar of the Well-Architected Framework](https://docs.microsoft.com/en-us/azure/architecture/framework/resiliency/overview). Reflect on each question and priorize/plan the initiatives of the Reliability playbook.

## Questions to make

* What reliability targets and metrics have you defined for your application?
* How have you ensured that your application architecture is resilient to failures?
* How have you ensured required capacity and services are available in targeted regions?
* How are you handling disaster recovery for this workload?
* What decisions have been taken to ensure the application platform meets your reliability requirements?
* What decisions have been taken to ensure the data platform meets your reliability requirements?
* How does your application logic handle exceptions and errors?
* What decisions have been taken to ensure networking and connectivity meets your reliability requirements?
* What reliability allowances for scalability and performance have you made?
* What reliability allowances for security have you made?
* What reliability allowances for operations have you made?
* How do you test the application to ensure it is fault tolerant?
* How do you monitor and measure application health?

## Initiatives

### Capture requirements

Everybody wants the highest level of reliability for their services, but this always comes with cost and architecture complexity tradeoffs. Therefore, the first thing to do regarding reliability is to identify how reliable we need our workload to be and what is required to achieve this objective.

Performing a [failure mode analysis](https://docs.microsoft.com/en-us/azure/architecture/resiliency/failure-mode-analysis) (FMA) helps you identify where your workload can fail and what are the risks of such failure. Consequently, it also helps you prioritize the solutions and initiatives that will remediate the identified reliability vulnerabilities.

Availability targets are an other important driver for identifying reliability requirements. For example, determining mean time to recovery (MTTR) or recovery time objective (RTO) targets will influence which reliability solutions will be adopted. More details [here](https://docs.microsoft.com/en-us/azure/architecture/framework/resiliency/overview#define-requirements).

Depending on your reliability requirements, Azure provides many high-availability and resiliency solutions to choose from, such as Availability Sets with Managed Disks, Availability Zones, Geo-Redundancy, Data Replication or Azure Site Recovery, just to name a few.

### Validate reliability best practices are applied

Once reliability requirements are clearly identified, you have several tools and actions at your disposal to validate whether your workloads are applying reliability best practices. Here are some actions that should be part of your todo list:

* Based on the specified availability targets and reliability requirements, design and implement a [comprehensive monitoring solution](https://docs.microsoft.com/en-us/azure/azure-monitor/monitor-reference) covering your workload end-to-end.
* Review the [Well-Architected Framework resiliency checklist](https://docs.microsoft.com/en-us/azure/architecture/checklist/resiliency-per-service)
* Remediate [Azure Advisor reliability recommendations](https://docs.microsoft.com/en-us/azure/advisor/advisor-high-availability-recommendations).
* Validate application and services' data and keys/secrets are being backed up according to reliability requirements
* Validate whether workloads have a disaster recovery strategy according to requirements
* Validate hybrid networking meets reliability requirements (for example, validate VPN/ExpressRoute active-active or active-passive setups)
* Consider re-architecting IaaS workloads into PaaS services for improved reliability and manageability
* Enforce reliability best practices with [Azure Policy](https://docs.microsoft.com/en-us/azure/governance/policy/overview). Here are some examples of built-in Azure Policies that can help:
  * [Azure Backup should be enabled for Virtual Machines](https://portal.azure.com/#blade/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2F013e242c-8828-4970-87b3-ab247555486d) (/providers/Microsoft.Authorization/policyDefinitions/013e242c-8828-4970-87b3-ab247555486d)
  * [Configure backup on VMs with a given tag to an existing recovery services vault in the same location](https://portal.azure.com/#blade/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2F345fa903-145c-4fe1-8bcd-93ec2adccde8) (/providers/Microsoft.Authorization/policyDefinitions/345fa903-145c-4fe1-8bcd-93ec2adccde8)
  * [Audit virtual machines without disaster recovery configured](https://portal.azure.com/#blade/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2F0015ea4d-51ff-4ce3-8d8c-f3f8f0179a56) (/providers/Microsoft.Authorization/policyDefinitions/0015ea4d-51ff-4ce3-8d8c-f3f8f0179a56)
  * [Audit VMs that do not use managed disks](https://portal.azure.com/#blade/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2F06a78e20-9358-41c9-923c-fb736d382a4d) (/providers/Microsoft.Authorization/policyDefinitions/06a78e20-9358-41c9-923c-fb736d382a4d)
  * [Key vault should have soft delete enabled](https://portal.azure.com/#blade/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2F1e66c121-a66a-4b1f-9b83-0fd99bf0fc2d) (/providers/Microsoft.Authorization/policyDefinitions/1e66c121-a66a-4b1f-9b83-0fd99bf0fc2d)
  * [Geo-redundant backup should be enabled for Azure Database for PostgreSQL](https://portal.azure.com/#blade/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2F48af4db5-9b8b-401c-8e74-076be876a430) (/providers/Microsoft.Authorization/policyDefinitions/48af4db5-9b8b-401c-8e74-076be876a430)
  * [Long-term geo-redundant backup should be enabled for Azure SQL Databases](https://portal.azure.com/#blade/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2Fd38fc420-0735-4ef3-ac11-c806f651a570) (/providers/Microsoft.Authorization/policyDefinitions/d38fc420-0735-4ef3-ac11-c806f651a570)
  * [Geo-redundant storage should be enabled for Storage Accounts](https://portal.azure.com/#blade/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2Fbf045164-79ba-4215-8f95-f8048dc1780b) (/providers/Microsoft.Authorization/policyDefinitions/bf045164-79ba-4215-8f95-f8048dc1780b)
* Identify custom reliability optimization opportunities with the [Azure Optimization Engine](https://github.com/helderpinto/AzureOptimizationEngine)
  * Deploy the engine in your environment and assess the initial results
  * Develop custom recommendations if needed

### Incorporate reliability in release engineering procedures

* Test for common failure scenarios by [triggering actual failures or by simulating them](https://docs.microsoft.com/en-us/azure/architecture/framework/resiliency/testing)
* Design and automate the [release processes to maximize availability](https://docs.microsoft.com/en-us/azure/architecture/framework/resiliency/overview#deploy-the-application-consistently), including infrastructure as code and rollback procedures
* Perform disaster recovery testing on a regular basis
