SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
INFRA_PATH=$(realpath "${SCRIPT_DIR}/../infrastructure")

export RG=$(terraform -chdir=${INFRA_PATH} output -raw RESOURCE_GROUP)
export MSI_NAME=$(terraform -chdir=${INFRA_PATH} output -raw MSI_NAME)

export ACR="bjdcsa.azurecr.io" #existing Azure Container Registry 
export AKS="gator-28237-aks"   #existing AKS with KEDA extension enabled
export AKS_RG="gator-28237_rg" #existing AKS RG 
