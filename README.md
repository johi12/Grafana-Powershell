
# Grafana Powershell Module

A Powershell implementation of the Grafana HTTP API

## Getting started

Put these files in $env:PSModulePath for module autoloading, or you can save them wherever you want and run
```cmd
Import-Module C:\Path\To\ModuleFolder\Grafana.psm1 
``` 

You also need to Authenticate, see help for the command Initialioze

## Develop locally

To have a Grafana instance to test against you can run a Grafana docker container.

```cmd
docker run -d -p 3000:3000 -e GF_SECURITY_ADMIN_PASSWORD=admin -e GF_SECURITY_ADMIN_USER=admin123 -e GF_INSTALL_PLUGINS=ryantxu-annolist-panel--name=grafana grafana/grafana
```

The ryantxu-annolist-panel plugin installed provides a nice panel that lists all annotations currently in the grafana database.