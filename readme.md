# Azure Log Analytics Workspace — On-Premises Export

This repository provides step-by-step documentation and scripts for exporting logs from Azure Log Analytics Workspace (LAW) to on-premises infrastructure.

- To request best practices for transferring logs from Azure to on‑premises environments.  
    (When using an Event Hub–based approach, is a Log Analytics Workspace still required?)
- To validate whether logs from all existing Zava connectors can be directly ingested into Event Hub via Diagnostic Settings.
- To seek guidance on Event Hub topology design.  
    In the case of Zava with a multi‑tenant environment, how many Event Hubs are required to transfer logs from multiple tenants to on‑premises infrastructure, and which key factors should be considered?
- To request details on the Event Hub charging model.  
    In the context of Zava, how would Event Hub pricing be structured and applied?
- To reconfirm our understanding of the charging model for Azure Log Analytics Workspace versus Azure Sentinel.  
    (Azure Sentinel is billed based on the log volume ingested into Log Analytics Workspace, with no additional charges for Sentinel features themselves—please confirm.)


Two export methods are covered:

| Method | Use Case | Status |
|--------|----------|--------|
| [One-time Bash Export](#) | Periodic backups, compliance reporting, on-demand retrieval | Scripted (`scripts/LAW Export.sh`) |
| [Event Hub Streaming](#) | Real-time transfer, high-volume, multi-tenant environments | Documented |

---

## Documents

### [01 — Transferring Logs from Azure to On-Premises](01%20Transferring%20logs%20from%20Azure%20to%20on‑premises%20environments.md)

Compares the two export architectures:
- **Option 1: Direct Export** — REST API query → local JSON/CSV (current script)
- **Option 2: Event Hub Streaming** — Diagnostic Settings → Event Hub → on-premises consumer

Includes multi-tenant topology guidance for Zava environments.

---

### [02 — Event Hubs Overview](02%20Event%20Hubs%20Overview.md)

Reference for Azure Event Hubs: tiers (Basic / Standard / Premium / Dedicated), throughput units, retention limits, and pricing.

---

### [03 — Sentinel Pricing](03%20Sentinel%20Pricing.md)

Sentinel commitment tier pricing table and KQL queries for auditing Sentinel and Azure Monitor costs from the FinOps ingestion table.

---

### [04 — Prepare Azure Resources for Exporting to Splunk](04%20Prepare%20Azure%20Resources%20for%20exporting%20to%20Splunk.md)

Steps to configure Event Hub and Microsoft Entra ID for streaming Defender for Cloud alerts to Splunk or IBM QRadar.

---

## Quick Start (One-Time Export)

See [scripts/How to run script.md](scripts/How%20to%20run%20script.md) for full setup instructions.

```bash
cd scripts
cp .env.example .env    # add your WORKSPACE_ID
chmod +x "LAW Export.sh"
az login
./"LAW Export.sh"
```

Output files are written to `scripts/output/`.
