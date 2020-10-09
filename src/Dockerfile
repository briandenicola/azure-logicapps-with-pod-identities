FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS installer-env

COPY . /src/dotnet-logicapp-app
RUN cd /src/dotnet-logicapp-app && \
    mkdir -p /home/site/wwwroot && \
    dotnet publish *.csproj --output /home/site/wwwroot

FROM mcr.microsoft.com/azure-functions/dotnet:3.0.14492-appservice

ENV AZURE_FUNCTIONS_ENVIRONMENT Production
ENV AzureWebJobsScriptRoot=/home/site/wwwroot \
    AzureFunctionsJobHost__Logging__Console__IsEnabled=true \
    FUNCTIONS_V2_COMPATIBILITY_MODE=true 

COPY --from=installer-env ["/home/site/wwwroot", "/home/site/wwwroot"]