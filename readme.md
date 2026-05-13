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

https://learn.microsoft.com/en-us/azure/sentinel/billing?tabs=simplified%2Ccommitment-tiers#understand-the-full-billing-model-for-microsoft-sentinel

https://www.microsoft.com/en-us/security/pricing/microsoft-sentinel/

---