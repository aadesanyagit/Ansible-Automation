# Add the service principal application ID and secret here
servicePrincipalClientId="d2aabe97-cd1c-4b67-878c-9e28bcde9fb7";
servicePrincipalSecret="<ENTER SECRET HERE>";


export subscriptionId="d81b8ec3-8529-485c-984e-34182260d492";
export resourceGroup="Arc-Deployment-WorkSpace-RG";
export tenantId="73822aac-4c17-4084-be61-b136b7d6de26";
export location="eastus";
export authType="principal";
export correlationId="544bec32-092d-486c-bb4d-3cad2e9b401c";
export cloud="AzureCloud";


# Download the installation package
output=$(wget https://aka.ms/azcmagent -O ~/install_linux_azcmagent.sh 2>&1);
if [ $? != 0 ]; then wget -qO- --method=PUT --body-data="{\"subscriptionId\":\"$subscriptionId\",\"resourceGroup\":\"$resourceGroup\",\"tenantId\":\"$tenantId\",\"location\":\"$location\",\"correlationId\":\"$correlationId\",\"authType\":\"$authType\",\"operation\":\"onboarding\",\"messageType\":\"DownloadScriptFailed\",\"message\":\"$output\"}" "https://gbl.his.arc.azure.com/log" &> /dev/null || true; fi;
echo "$output";

# Install the hybrid agent
bash ~/install_linux_azcmagent.sh;

# Run connect command
sudo azcmagent connect --service-principal-id "$servicePrincipalClientId" --service-principal-secret "$servicePrincipalSecret" --resource-group "$resourceGroup" --tenant-id "$tenantId" --location "$location" --subscription-id "$subscriptionId" --cloud "$cloud" --correlation-id "$correlationId";
