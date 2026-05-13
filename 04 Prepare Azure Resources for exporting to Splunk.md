
https://learn.microsoft.com/en-us/azure/defender-for-cloud/export-to-splunk-or-qradar

In order to stream Microsoft Defender for Cloud security alerts to IBM QRadar and Splunk, you have to set up resources in Azure, such as Event Hubs and Microsoft Entra ID. Here are the instructions for configuring these resources in the Azure portal, but you can also configure them using a PowerShell script. Make sure you review [Stream alerts to QRadar and Splunk](https://learn.microsoft.com/en-us/azure/defender-for-cloud/export-to-siem#stream-alerts-to-qradar-and-splunk) before you configure the Azure resources for exporting alerts to QRadar and Splunk.


## Connect the event hub to your preferred solution using the built-in connectors

https://learn.microsoft.com/en-us/azure/defender-for-cloud/export-to-siem#connect-the-event-hub-to-your-preferred-solution-using-the-built-in-connectors

| Tool       | Hosted in Azure | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| ---------- | --------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| IBM QRadar | No              | The Microsoft Azure DSM and Microsoft Azure Event Hubs Protocol are available for download from [the IBM support website](https://www.ibm.com/docs/en/qsip/7.4?topic=microsoft-azure-platform).                                                                                                                                                                                                                                                                                       |
| Splunk     | No              | [Splunk Add-on for Microsoft Cloud Services](https://splunkbase.splunk.com/app/3110/) is an open source project available in Splunkbase.  <br>  <br>If you can't install an add-on in your Splunk instance, for example if you're using a proxy or running on Splunk Cloud, you can forward these events to the Splunk HTTP Event Collector using [Azure Function For Splunk](https://github.com/splunk/azure-functions-splunk), which is triggered by new messages in the event hub. |

## Splunk

Splunk Add-on for Microsoft Cloud Services https://splunkbase.splunk.com/app/3110

The Splunk Add-on for Microsoft Cloud Services allows a Splunk software administrator to pull activity logs, service status, operational messages, Azure audit, Azure resource data and Azure Storage Table and Blob data from a variety of Microsoft cloud services using Event Hubs, Azure Service Management APIs and Azure Storage API. This add-on provides the inputs and CIM-compatible knowledge to use with other Splunk apps, such as Splunk Enterprise Security and the Splunk App for PCI Compliance and Splunk IT Service Intelligence.