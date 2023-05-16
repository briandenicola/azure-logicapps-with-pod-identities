# Overview

A demo repository of using Azure Functions in a Docker container using AKS Workload Identities for binding authentications

# Infrastructure Setup
```bash
cd infrastructure
terraform init
terraform apply
az aks get-credentials -n ${existing_aks_cluster_name} -g ${existing_aks_cluster_rg}
kubectl create ns logicapp-eventprocessor
./scripts/pod-identity.sh --cluster-name ${existing_aks_cluster_name} -n logicapp-eventprocessor -i ${managed_identity_name}
```

# Deploy API
```bash
cd src/eventprocessor
docker build -t ${existing_docker_repo}/keygenerator/eventprocessor:1.0 .
docker push ${existing_docker_repo}/keygenerator/eventprocessor:1.0
cd deploy
helm upgrade -i eventprocessor -n logicapp-eventprocessor \
 --set "ACR_NAME=${existing_docker_repo}" \ 
 --set "MSI_CLIENTID=${managed_identity_clientid}" \
 --set "MSI_SELECTOR=${managed_identity_name}" \
 --set "COMMIT_VERSION=1.0" \
 --set "EH_CONNECTION_STRING=${event_hub_namespace_name}.servicebus.windows.net" \
 --set "WEBJOB_STORAGE_ACCOUNT_NAME=${storage_account_name}" \
 .
```

# Test
```bash
az login 
dotnet run -n ${app-name}-eventhub
```