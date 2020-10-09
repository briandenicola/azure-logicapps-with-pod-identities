# Logic Apps on AKS

A simple deployment of a HTTP Triggered Logic Apps inside AKS. HPA or KNative can be used to autoscale this Logic App Container since the Logic Apps uses an HTTP Trigger. Keda can not be used because _still_ does not support HTTP Triggers natively. This Readme walks through deploying Logic Apps with KNative

# Requirements 
* An AKS cluster
* An Azure Container Repository with Admin user login enabled. 
    * Knative only supports this model for private repos

## Istio for Knative
1. curl -L https://git.io/getLatestIstio | sh -
2. cd istio-${ISTIO_VERSION}/bin
3. istioctl manifest install -f ../deploy/istio-minimal-operator.yaml
4. kubectl get pods --namespace istio-system
    * Verify all pods are running
5. kubectl apply --filename https://github.com/knative/net-istio/releases/download/v0.18.0/release.yaml
6. kubectl --namespace istio-system get service istio-ingressgateway
7. kubectl get svc -n istio-system
    * Copy the External IP Address for istio-ingressgateway 
    * Create DNS A Record pointting *.knative.bjd.demo
8. Patch the config-domain configmap
   ```
   kubectl patch configmap/config-domain \
    --namespace knative-serving \
    --type merge \
    --patch '{"data":{"knative.bjd.demo":""}}'
   ```
   
## Azure Resources
1. Create a Resource Group
    * Save name, location, Subscription Id, and Tenant Id
2. Create Storage Account 
    * This will be used by the Logic App to maintain state
    * Save off its connection string
2. echo {{RG_NAME}} | base64 -w 0 
3. echo {{SUB_ID} | base64 -w 0 
4. echo {{TENANT_ID}} | base64 -w 0 
5. echo {{STORAGE_CONSTR}} | base64 -w 0
6. Update azure-logicapps-runtime-secrets section in ./deploy/configmap.yaml with values from above

# Build 
1. az acr login -n {{ACR_NAME}}
2. docker build -t {{ACR_NAME}}.azurecr.io/logicapps/simplehttptrigger:0.1 .
3. docker push {{ACR_NAME}}.azurecr.io/logicapps/simplehttptrigger:0.1

# Deploy
1. Update {{ACR_NAME}} in ./deploy/logicapp.yaml
2. Create docker secret
    ```
    kubectl create secret docker-registry acr-secrets \
    --docker-server={{ACR_NAME}}.azurecr.io \
    --docker-email=sample@example.com \
    --docker-username={{ACR_NAME}} \
    --docker-password={{ACR_PASSWORD}
    ```
2. kubectl apply --filename ./deploy/configmap.yaml
    * The configmap has a hardcoded master key.  This is used for demostration purposes only. 
3. kubectl apply --filename ./deploy/logicapp.yaml

# Validate and Test 
1. kubectl get services.serving.knative.dev
2. kubectl get pods
3. kubectl describe services.serving.knative.dev  | grep -i URL
4. Get Invocation URL:
    $uri = Invoke-RestMethod -Method Post -uri "http://azure-logicapps-test.default.knative.bjd.demo/runtime/webhooks/workflow/api/management/workflows/Simple/triggers/manual/listCallbackUrl?api-version=2019-10-01-edge-preview&code=907f2b9fe55f2d7620ef43d11bd89cd4"
    $uri.queries.sig
4. Test with hey (https://github.com/rakyll/hey):
     * Example: hey -m POST -c 50 -z 30s "http://azure-logicapps-test.default.knative.bjd.demo/api/Simple/triggers/manual/invoke?api-version=2020-05-01-preview&sp=%2Ftriggers%2Fmanual%2Frun&sv=1.0&sig={{$uri.queries.sig}}
     * kubectl get pods -w

# Roadmap
-[ ] : Update Deployment to Helm
