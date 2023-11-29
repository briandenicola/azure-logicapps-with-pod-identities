FROM mcr.microsoft.com/azure-functions/node:4-node18-appservice

ENV AzureWebJobsScriptRoot=/home/site/wwwroot
ENV AzureFunctionsJobHost__Logging__Console__IsEnabled=true

COPY . /home/site/wwwroot
COPY ./out /home/site/wwwroot

WORKDIR /home/site/wwwroot
RUN npm install 