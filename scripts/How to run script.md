## Overview

This project provides automated extraction and transfer of Azure activity logs to on-premise infrastructure for compliance, archival, and analysis purposes.

### Key Features

- **Automated Extraction** - Query Azure Log Analytics and export to local storage
- **Multiple Transport Options** - One-time exports or continuous streaming via Event Hub
- **Data Formats** - JSON and CSV outputs for flexible downstream processing

---

## Prerequisites

### Required Software

| Component | Requirement | Install |
|-----------|------------|---------|
| **Azure CLI** | v2.0+ | `brew install azure-cli` (macOS) or [Guide](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli) |
| **jq** | v1.6+ | `brew install jq` (macOS) or `sudo apt-get install jq` (Linux) |
| **bash** | v4.0+ | Standard on macOS/Linux |

### Azure Prerequisites

- Active Azure subscription with Log Analytics workspace
- Query permissions on target workspace
- Authenticated via `az login`

**Verify Setup:**
```bash
az account show
az workspace list
```

---

## Installation

### 1. Clone Repository

```bash
cd law_export
cd scripts
```

### 2. Configure Environment

```bash
# Copy template
cp .env.example .env

# Edit with your Workspace ID
nano .env
# or: vim .env
```

**Required Configuration (.env):**
```bash
WORKSPACE_ID="your-workspace-id-here"
```

### 3. Make Script Executable

```bash
chmod +x "LAW Expoert.sh"
```

### 4. Test Authentication

```bash
az login
az account show
```

---

## Usage

### One-Time Export

Quick extraction of activity logs to local CSV/JSON files.

```bash
cd scripts
./LAW\ Expoert.sh
```

**Output Generated:**
- `output/output.json` - Raw API response
- `output/output.csv` - Formatted data export
- `output/transfer.log` - Execution log

### Scheduled Exports (Cron)

For regular automated transfers:

**macOS/Linux:**
```bash
# Edit crontab
crontab -e

# Daily at 2 AM
0 2 * * * /Users/smithm/law_export/scripts/LAW\ Expoert.sh >> /var/log/law_export.log 2>&1
```

**Windows (Task Scheduler):**
1. Open Task Scheduler
2. Create Basic Task
3. Set Trigger: Daily / Weekly as needed
4. Set Action: 
   - Program: `C:\Program Files\Git\bin\bash.exe`
   - Arguments: `"C:\path\to\LAW Expoert.sh"`