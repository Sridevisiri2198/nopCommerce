FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
ADD . /dotnetapp
WORKDIR /dotnetapp
RUN dotnet publish -c Release src/Presentation/Nop.Web/Nop.Web.csproj -o /dotnetapp/devops
FROM  mcr.microsoft.com/dotnet/aspnet:9.0 AS runtime
COPY --from=build /dotnetapp/devops /app
WORKDIR /app
EXPOSE 5000
CMD ["dotnet", "Nop.Web.dll", "--urls", "http://0.0.0.0:5000"]
