FROM microsoft/aspnetcore-build:2.0 AS build-env
WORKDIR /app

# Copy csproj and restore as distinct layers
COPY Tinygubackend/Tinygubackend.csproj ./
RUN dotnet restore

# Copy everything else and build
COPY . ./
RUN dotnet publish -c Release -o out

# Build runtime image
FROM microsoft/aspnetcore:2.0
ENV ASPNETCORE_ENVIRONMENT=Development
WORKDIR /app
COPY --from=build-env /app/Tinygubackend/out .
ENTRYPOINT ["dotnet", "Tinygubackend.dll"]