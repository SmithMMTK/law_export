## Export Azure Log Analytics query results to CSV

# Load WORKSPACE_ID from .env file
source .env

WORKSPACE_ID="$WORKSPACE_ID"

TOKEN=$(az account get-access-token \
  --resource https://api.loganalytics.io \
  --query accessToken -o tsv)

curl -sS -X POST \
  "https://api.loganalytics.io/v1/workspaces/${WORKSPACE_ID}/query" \
  -H "Authorization: Bearer ${TOKEN}" \
  -H "Content-Type: application/json" \
  -d '{
    "query": "AzureActivity | where TimeGenerated > ago(1d)",
    "timespan": "P1D"
  }' > output.json

jq -r '
  .tables[0]
  | (.columns | map(.name)), (.rows[])
  | @csv
' output.json > output.csv
