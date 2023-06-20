# Basic Dockerfile
# 
# docker build -f ./code/iaccWeb/Dockerfile -t iaccweb:v0.1 ./code/iaccWeb --build-arg tag=v0.1

FROM mcr.microsoft.com/dotnet/sdk:7.0 as build
WORKDIR /src
COPY iaccWeb.csproj .
RUN dotnet restore
COPY . .
RUN dotnet publish -c release -o /app

FROM mcr.microsoft.com/dotnet/aspnet:7.0 as publish
WORKDIR /app
# ENV EnvName=Docker
COPY --from=build /app .
ENTRYPOINT ["dotnet","iaccWeb.dll"]