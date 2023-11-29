FROM mcr.microsoft.com/azure-functions/node:4-node18-appservice

ENV AzureWebJobsScriptRoot=/home/site/wwwroot
ENV AzureFunctionsJobHost__Logging__Console__IsEnabled=true

WORKDIR /home/site/wwwroot
COPY ./out .
RUN npm install