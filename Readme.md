# Logic Apps on AKS

A simple deployment of a HTTP Triggered Logic Apps inside AKS

Since this Logic Apps uses an HTTP Trigger, Knative is required if you want to do Scale from Zero.  Keda does not support HTTP Triggers natively
This [link](https://github.com/briandenicola/azure-functions-in-containers/blob/master/HttpTrigger/Readme-Knative.md) helps with getting Knative installed into AKS