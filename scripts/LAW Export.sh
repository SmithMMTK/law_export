## Export Azure Log Analytics query results to CSV

# Load WORKSPACE_ID from .env file
source .env

WORKSPACE_ID="$WORKSPACE_ID"

TOKEN=$(az account get-access-token \
  --resource https://api.loganalytics.io \
  --query accessToken -o tsv)

mkdir -p output

LOG_FILE="output/transfer.log"
echo "[$(date -u +"%Y-%m-%dT%H:%M:%SZ")] Starting export..." >> "$LOG_FILE"

curl -sS -X POST \
  "https://api.loganalytics.io/v1/workspaces/${WORKSPACE_ID}/query" \
  -H "Authorization: Bearer ${TOKEN}" \
  -H "Content-Type: application/json" \
  -d '{
    "query": "AzureActivity | where TimeGenerated > ago(1d)",
    "timespan": "P1D"
  }' > output/output.json

jq -r '
  .tables[0]
  | (.columns | map(.name)), (.rows[])
  | @csv
' output/output.json > output/output.csv

echo "[$(date -u +"%Y-%m-%dT%H:%M:%SZ")] Export complete." >> "$LOG_FILE"
