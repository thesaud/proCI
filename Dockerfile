FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build
WORKDIR /src

COPY . .
RUN dotnet restore DemoApi/DemoApi.csproj
RUN dotnet test DemoApi.Tests/DemoApi.Tests.csproj --configuration Release
RUN dotnet publish DemoApi/DemoApi.csproj \
    --configuration Release \
    --output /app/publish

FROM mcr.microsoft.com/dotnet/aspnet:10.0 AS runtime
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "DemoApi.dll"]