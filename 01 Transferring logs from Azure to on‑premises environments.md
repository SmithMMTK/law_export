
## Architecture Options

### Option 1: Direct Export (Current)

**Best for:** Periodic backups, compliance reporting, on-demand data retrieval

```
Azure Log Analytics 
    ↓
[Direct Query via REST API]
    ↓
Local Storage (JSON/CSV)
```

**Advantages:**
- Simple implementation
- No additional Azure resources
- Full data control
- Easy to schedule

---

### Option 2: Event Hub Streaming (Continuous)

**Best for:** Real-time log transfer, high-volume scenarios, multi-tenant environments

```
Azure Resources (Connectors)
    ↓
[Diagnostic Settings]
    ↓
Event Hub
    ↓
Event Hub Consumer (On-Premise)
    ↓
Local Storage/Database
```

**Advantages:**
- Near real-time data delivery (low latency)
- Handles high log volume without polling
- Supports multiple consumers (Splunk, QRadar, custom) from a single stream
- Native integration with Diagnostic Settings — no Log Analytics Workspace required for forwarding

**Is a Log Analytics Workspace still required?**

No — when using the Event Hub approach, logs can be sent **directly from Diagnostic Settings to Event Hub** without routing through a Log Analytics Workspace. However, a workspace may still be needed if:
- You require KQL-based querying or alerting via Sentinel
- You need long-term retention within Azure
- Other workloads depend on the workspace

**Multi-Tenant Topology (Zava)**

For multi-tenant environments, the recommended approach is **one Event Hub namespace per tenant** (or per logical grouping), with separate Event Hub instances per log category:

```
Tenant A  →  Event Hub Namespace A  →  Event Hub (AuditLogs)
                                    →  Event Hub (SignInLogs)
Tenant B  →  Event Hub Namespace B  →  Event Hub (AuditLogs)
                                    →  Event Hub (SignInLogs)
```

Key factors to consider:
- **Isolation** — separate namespaces prevent one tenant's traffic from affecting another
- **Throughput Units (TU)** — size per namespace based on expected log volume (1 TU = 1 MB/s ingress)
- **Consumer groups** — allocate one consumer group per downstream consumer (e.g. Splunk gets its own group)
- **Retention** — Standard tier retains up to 7 days; Premium/Dedicated up to 90 days

