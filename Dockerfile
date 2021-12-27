# https://hub.docker.com/_/microsoft-dotnet

FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
ADD WebApplication2 /source

# copy csproj and restore as distinct layers
COPY *.sln .
RUN dotnet restore

RUN dotnet publish -c release -o /app --no-restore

# final stage/image
FROM mcr.microsoft.com/dotnet/aspnet:5.0

WORKDIR /app
COPY --from=build /app ./
ENTRYPOINT ["dotnet", "webapplication2.dll"]