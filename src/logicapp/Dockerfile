FROM mcr.microsoft.com/azure-functions/node:4-node18-appservice
#FROM mcr.microsoft.com/azure-functions/node:3.0

ENV AzureWebJobsScriptRoot=/home/site/wwwroot
ENV AzureFunctionsJobHost__Logging__Console__IsEnabled=true

COPY . /home/site/wwwroot
COPY ./bin/Debug/netcoreapp3.1 /home/site/wwwroot