# ⚠️In Progress ⚠️

# Overview

A demo repository of using Azure Functions in a Docker container using AKS Workload Identities for binding authentications

# Infrastructure Setup
```bash

export REGION=southcentralus
terraform -chdir=./infrastructure workspace new ${REGION} || true
terraform -chdir=./infrastructure workspace select ${REGION}
terraform -chdir=./infrastructure init
terraform -chdir=./infrastructure apply -auto-approve -var "region=${REGION}"

vi ./scripts/set-env.sh
    #Update the following lines
    #export AKS="" #existing AKS with KEDA extension enabled
    #export AKS_RG="" #existing AKS RG 
    #export ACR="" #existing Azure Container Registry 

source ./scripts/set-env.sh
az aks get-credentials -n ${AKS} -g ${AKS_RG}
kubectl create ns logicapp-eventprocessor
bash ./scripts/pod-identity.sh --cluster-name ${AKS} -n logicapp-eventprocessor -i ${MSI_NAME}
```

# Deploy API
## Build 
```bash
cd src/eventprocessor
source ./scripts/set-env.sh
docker build -t ${ACR}/la-eventprocessor:1.0 .
docker push ${ACR}/la-eventprocessor:1.0
```

## Deploy
```bash
cd deploy
helm update -i eventprocessor -n logicapp-eventprocessor --set "ACR_NAME=${ACR}" --set "COMMIT_VERSION=1.0" --set "MSI_CLIENTID=${MSI_CLIENT_ID}" --set "MSI_SELECTOR=${MSI_NAME}" --set "EVENTHUB_NAMESPACE_NAME=${EVENTHUB_NAMESPACE_NAME}" --set "WEBJOB_STORAGE_ACCOUNT_NAME=${STORAGE_ACCOUNT_NAME}" --set "WORKFLOWS_SUBSCRIPTION_ID=${MSI_SUBSCRIPTION_ID}" --set "WORKFLOWS_TENANT_ID=${MSI_TENANT_ID}" --set "WORKFLOWS_RESOURCE_GROUP_NAME=${RG}" --set "WORKFLOWS_LOCATION_NAME=${LOCATION}" .
```

# Test
```bash
az login 
source ./scripts/set-env.sh
dotnet run -n ${APP_NAME}-eventhub
```