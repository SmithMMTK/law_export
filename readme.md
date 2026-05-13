# Azure Log Analytics to On-Premise Data Transfer

## Discussion Topics

- To request best practices for transferring logs from Azure to on‑premises environments.  
  (When using an Event Hub–based approach, is a Log Analytics Workspace still required?)
- To validate whether logs from all existing Zava connectors can be directly ingested into Event Hub via Diagnostic Settings.
- To seek guidance on Event Hub topology design.  
  In the case of Zava with a multi‑tenant environment, how many Event Hubs are required to transfer logs from multiple tenants to on‑premises infrastructure, and which key factors should be considered?
- To request details on the Event Hub charging model.  
  In the context of Zava, how would Event Hub pricing be structured and applied?
- To reconfirm our understanding of the charging model for Azure Log Analytics Workspace versus Azure Sentinel.  (Azure Sentinel is billed based on the log volume ingested into Log Analytics Workspace, with no additional charges for Sentinel features themselves—please confirm.)

---

[01 Transferring logs from Azure to on‑premises environments](01%20Transferring%20logs%20from%20Azure%20to%20on‑premises%20environments.md)

- Option 1: Direct Export (Current)
- Option 2: Event Hub Streaming (Continuous)

---

[02 Event Hubs Overview](02%20Event%20Hubs%20Overview.md)

Azure Event Hubs is a fully managed, real-time data streaming platform that can ingest millions of events per second with low latency. As a native Azure service with built-in Apache Kafka compatibility, Event Hubs enables you to run existing Kafka workloads without code changes or cluster management overhead.

---

[03 Sentinel Pricing](03%20Sentinel%20Pricing.md)

Commitment tiers offer predictable costs and savings up to 52% over Pay-As-You-Go rates by allowing customers to reserve daily data ingestion capacity for the analytics tier, from 100 GB to 50,000 GB. They can be upgraded at any time and downgraded after 31 days. Usage exceeding the commitment tier will be billed at the same discounted rate.[3](https://www.microsoft.com/en-us/security/pricing/microsoft-sentinel/#footnote3)

---

[04 Prepare Azure Resources for exporting to Splunk](04%20Prepare%20Azure%20Resources%20for%20exporting%20to%20Splunk.md)

In order to stream Microsoft Defender for Cloud security alerts to IBM QRadar and Splunk, you have to set up resources in Azure, such as Event Hubs and Microsoft Entra ID. Here are the instructions for configuring these resources in the Azure portal, but you can also configure them using a PowerShell script. Make sure you review [Stream alerts to QRadar and Splunk](https://learn.microsoft.com/en-us/azure/defender-for-cloud/export-to-siem#stream-alerts-to-qradar-and-splunk) before you configure the Azure resources for exporting alerts to QRadar and Splunk.

The Splunk Add-on for Microsoft Cloud Services allows a Splunk software administrator to pull activity logs, service status, operational messages, Azure audit, Azure resource data and Azure Storage Table and Blob data from a variety of Microsoft cloud services using Event Hubs, Azure Service Management APIs and Azure Storage API. This add-on provides the inputs and CIM-compatible knowledge to use with other Splunk apps, such as Splunk Enterprise Security and the Splunk App for PCI Compliance and Splunk IT Service Intelligence.

---
