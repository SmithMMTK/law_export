
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
Azure Resources (AIS Connectors)
    ↓
[Diagnostic Settings]
    ↓
Event Hub
    ↓
Event Hub Consumer (On-Premise)
    ↓
Local Storage/Database
```

