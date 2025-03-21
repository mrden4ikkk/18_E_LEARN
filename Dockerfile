FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Copy and restore the project
COPY . .
RUN dotnet restore "18_E_LEARN.Web/18_E_LEARN.Web.csproj"

# Install the dotnet-ef tool locally
RUN dotnet tool install -g dotnet-ef
ENV PATH $PATH:/root/.dotnet/tools
RUN dotnet-ef database update --startup-project "18_E_LEARN.Web" --project "18_E_LEARN.DataAccess/18_E_LEARN.DataAccess.csproj"

# Publish the application
RUN dotnet publish "18_E_LEARN.Web/18_E_LEARN.Web.csproj" -c Release -o /app/build

# Build the final image
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
COPY --from=build /app/build .
EXPOSE 80
ENTRYPOINT ["dotnet", "18_E_LEARN.Web.dll"]
