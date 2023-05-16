SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
INFRA_PATH=$(realpath "${SCRIPT_DIR}/../infrastructure")

export RG=$(terraform -chdir=${INFRA_PATH} output -raw RESOURCE_GROUP)
export MSI_NAME=$(terraform -chdir=${INFRA_PATH} output -raw MSI_NAME)
export MSI_CLIENT_ID=$(terraform -chdir=${INFRA_PATH} output -raw MSI_CLIENT_ID)
export MSI_TENANT_ID=$(terraform -chdir=${INFRA_PATH} output -raw MSI_TENANT_ID)
export MSI_SUBSCRIPTION_ID=$(terraform -chdir=${INFRA_PATH} output -raw MSI_SUBSCRIPTION_ID)
export STORAGE_ACCOUNT_NAME=$(terraform -chdir=${INFRA_PATH} output -raw STORAGE_ACCOUNT_NAME)
export LOCATION=$(terraform -chdir=${INFRA_PATH} output -raw LOCATION)
export APP_NAME=$(terraform -chdir=${INFRA_PATH} output -raw APP_NAME)
export EVENTHUB_NAMESPACE_NAME=$(terraform -chdir=${INFRA_PATH} output -raw EVENTHUB_NAMESPACE_NAME)

export ACR="bjdcsa.azurecr.io" #existing Azure Container Registry 
export AKS="gator-28237-aks"   #existing AKS with KEDA extension enabled
export AKS_RG="gator-28237_rg" #existing AKS RG 
