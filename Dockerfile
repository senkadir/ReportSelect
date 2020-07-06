FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build
WORKDIR /app

RUN mkdir -p /ReportSelect.Api/ 
RUN mkdir -p /ReportSelect.Core/ 
RUN mkdir -p /ReportSelect.Data/ 
RUN mkdir -p /ReportSelect.Items/ 

COPY ./src/ReportSelect.Api/. ./ReportSelect.Api
COPY ./src/ReportSelect.Core/. ./ReportSelect.Core
COPY ./src/ReportSelect.Data/. ./ReportSelect.Data
COPY ./src/ReportSelect.Items/. ./ReportSelect.Items

RUN dotnet restore ./ReportSelect.Api/ReportSelect.Api.csproj

RUN dotnet publish ./ReportSelect.Api/ -c Release -o /app/out

FROM mcr.microsoft.com/dotnet/core/aspnet:3.1 AS runtime

WORKDIR /app

COPY --from=build /app/out .

ENV ASPNETCORE_URLS http://*:5000
ENV ASPNETCORE_ENVIRONMENT Docker

EXPOSE 5000

ENTRYPOINT ["dotnet","ReportSelect.Api.dll"]