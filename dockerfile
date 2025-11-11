# ===== BUILD STAGE =====
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /dotnetapp

# Copy all source code
COPY . .

# Restore dependencies
RUN dotnet restore src/Presentation/Nop.Web/Nop.Web.csproj

# Build and publish the application
RUN dotnet publish -c Release src/Presentation/Nop.Web/Nop.Web.csproj -o /dotnetapp/devops

# ===== RUNTIME STAGE =====
FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS runtime
WORKDIR /app

# Copy published files from build stage
COPY --from=build /dotnetapp/devops .

# Expose port 5000
EXPOSE 5000

# Run the application
ENTRYPOINT ["dotnet", "Nop.Web.dll", "--urls", "http://0.0.0.0:5000"]
