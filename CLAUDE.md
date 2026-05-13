# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Repo Is

Customer-facing documentation and scripts for exporting data from Azure Log Analytics Workspace (LAW) to on-premises infrastructure. Covers two methods:

1. **One-time bash export** — implemented in `scripts/LAW Export.sh`
2. **Event Hub streaming** — documented (not yet scripted); for continuous/real-time transfer

Reference docs cover Event Hub pricing, multi-tenant topology, Sentinel pricing, and SIEM integration (Splunk/QRadar).

## Running the Export Script

All commands run from `scripts/`:

```bash
cd scripts

# One-time setup
cp .env.example .env          # then add your WORKSPACE_ID
chmod +x "LAW Export.sh"
az login && az account show   # verify Azure auth

# Run export
./"LAW Export.sh"
```

**Prerequisites:** Azure CLI v2.0+, jq v1.6+, bash v4.0+

**Outputs written to `scripts/output/`:**
- `output.json` — raw API response from Log Analytics
- `output.csv` — CSV converted via `jq`
- `transfer.log` — timestamped execution log

## Script Architecture

`LAW Export.sh` does four things in sequence:
1. Sources `WORKSPACE_ID` from `.env`
2. Fetches a bearer token via `az account get-access-token` targeting `https://api.loganalytics.io`
3. POSTs a KQL query (`AzureActivity | where TimeGenerated > ago(1d)`) to the Log Analytics REST API
4. Transforms the JSON response to CSV using `jq`

The `.env` file must be in the same directory as the script (it is `source`d with a relative path).

## Scheduled Execution

```bash
# macOS/Linux cron — daily at 2 AM
crontab -e
0 2 * * * /path/to/law_export/scripts/LAW\ Export.sh >> /var/log/law_export.log 2>&1
```

## Architecture Options (documented in `01 Transferring logs...`)

**Option 1 — Direct Export (current script):** REST API poll → local JSON/CSV. Simple, no extra Azure resources needed.

**Option 2 — Event Hub Streaming:** Diagnostic Settings → Event Hub → on-premises consumer. Required for real-time/high-volume scenarios. A Log Analytics Workspace is *not* required for this path unless Sentinel/KQL querying is also needed.

For multi-tenant deployments (Zava context): one Event Hub namespace per tenant, separate Event Hub instances per log category, one consumer group per downstream consumer.

## KQL Cost Queries

Sentinel and Azure Monitor cost queries against `Costs_final_v1_2` are in `03 Sentinel Pricing.md`. Adjust `startDate`/`lastDay` variables for the desired billing period.
