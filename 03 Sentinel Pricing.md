
https://learn.microsoft.com/en-us/azure/sentinel/billing?tabs=simplified%2Ccommitment-tiers#understand-the-full-billing-model-for-microsoft-sentinel

https://www.microsoft.com/en-us/security/pricing/microsoft-sentinel/

### Sentinel

The 50 GB commitment tier is available in public preview, with promotional pricing starting October 1, 2025, until June 30, 2026. Customers who sign up during this period will lock in promotional pricing until March 31, 2027. Promotional price varies by region and is subject to change.[2](https://www.microsoft.com/en-us/security/pricing/microsoft-sentinel/#footnote2)

| SKU                   | Meter type          | Price       |
| --------------------- | ------------------- | ----------- |
| 50 GB Commitment Tier | Commitment Tier/Day | $161.25 USD |
|                       |                     |             |

### Sentinel Pricing

Commitment tiers offer predictable costs and savings up to 52% over Pay-As-You-Go rates by allowing customers to reserve daily data ingestion capacity for the analytics tier, from 100 GB to 50,000 GB. They can be upgraded at any time and downgraded after 31 days. Usage exceeding the commitment tier will be billed at the same discounted rate.[3](https://www.microsoft.com/en-us/security/pricing/microsoft-sentinel/#footnote3)

| SKU                      | Meter type          | Price        |
| ------------------------ | ------------------- | ------------ |
| Pay-as-you-go            | Analysis (GB)       | $4.3 USD     |
| 100 GB Commitment Tier   | Commitment Tier/Day | $296 USD     |
| 200 GB Commitment Tier   | Commitment Tier/Day | $548 USD     |
| 300 GB Commitment Tier   | Commitment Tier/Day | $800 USD     |
| 400 GB Commitment Tier   | Commitment Tier/Day | $1037.33 USD |
| 500 GB Commitment Tier   | Commitment Tier/Day | $1265 USD    |
| 1000 GB Commitment Tier  | Commitment Tier/Day | $2480 USD    |
| 2000 GB Commitment Tier  | Commitment Tier/Day | $4800 USD    |
| 5000 GB Commitment Tier  | Commitment Tier/Day | $11550 USD   |
| 10000 GB Commitment Tier | Commitment Tier/Day | $22240 USD   |
| 25000 GB Commitment Tier | Commitment Tier/Day | $53450 USD   |
| 50000 GB Commitment Tier | Commitment Tier/Day | $102600 USD  |

### Workspace with Sentinel enabled

If a workspace has [Microsoft Sentinel](https://azure.microsoft.com/pricing/details/azure-sentinel) enabled, data ingestion for Auxiliary and Basic Logs is billed using Sentinel meters. If a workspace has Microsoft Sentinel enabled and is in a Sentinel simplified plan tier, data ingestion for Analytics Logs is billed using Sentinel meters. If Sentinel has data lake enabled, then query, search job and long-term retention on the workspace is billed using Sentinel meters.

https://learn.microsoft.com/en-us/azure/azure-monitor/logs/cost-logs#pricing-model

---
## KQL Reference

### Query Sentinel cost from FinOps Ingest 

```sql
let startDate = datetime(2026-01-01);
let lastDay = datetime(2026-05-01);
Costs_final_v1_2
| where BillingPeriodStart between (startDate .. lastDay)
| where x_SkuMeterCategory == "Sentinel"
| extend discount_rate = strcat(round(x_TotalDiscountPercent * 100, 0), "%")
| summarize tolong(sum(BilledCost)) by format_datetime(BillingPeriodStart,"yyyy-MM-dd"), x_SkuMeterCategory , x_CustomerName, SubAccountName, discount_rate,SkuPriceId
| evaluate pivot(BillingPeriodStart, sum(sum_BilledCost), x_SkuMeterCategory, x_CustomerName, SubAccountName,discount_rate,SkuPriceId)
```

### Query Azure Monitor cost from FinOps Ingest 

```sql
let startDate = datetime(2026-01-01);
let lastDay = datetime(2026-04-01);
Costs_final_v1_2
| where BillingPeriodStart between (startDate .. lastDay)
| where x_SkuMeterCategory contains "Azure Monitor"
| extend discount_rate = strcat(round(x_TotalDiscountPercent * 100, 0), "%")
| summarize tolong(sum(BilledCost)) by format_datetime(BillingPeriodStart,"yyyy-MM-dd"), x_SkuMeterCategory , x_CustomerName, SubAccountName, discount_rate, SkuMeter
| where sum_BilledCost > 0
| evaluate pivot(BillingPeriodStart, sum(sum_BilledCost), x_SkuMeterCategory, x_CustomerName, SubAccountName,SkuMeter,discount_rate)
```

