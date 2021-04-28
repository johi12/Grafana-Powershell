function Initialize-Authentication {
    <#
    .SYNOPSIS
        Adds authencation information to script variables

        You can choose either username and password (Basic Auth) or API key (Bearer token)

    .PARAMETER BaseUrl
        Grafana base Url

    .PARAMETER APIKey
        API key generated in Grafana.

    .EXAMPLE
        PS C:\> Initialize-Authentication -APIKey "123sad1231231123213ex=="

        Authenticate using a bearer token

    .LINK
        https://grafana.com/docs/grafana/latest/http_api/auth/#create-api-token

    #>
    [CmdletBinding()]
    param(
        # Parameter help description
        [Parameter(
            Mandatory = $true
        )] [string] $BaseUrl,
        [Parameter(
            Mandatory = $true,
            ParameterSetName = "APIKey"
        )] [string] $APIKey
    )

    $BaseUrl = if (Confirm-Url $BaseUrl) {
        "$BaseUrl/api"
    }

    $Credentials = if ($APIKey) {
        "Bearer $APIKey"
    }



    $Params = @{
        "URI"     = $BaseUrl + "/dashboards/home"
        "Method"  = "Get"
        "Headers" = @{
            "Content-Type"  = "application/json"
            "Authorization" = $Credentials
        }

    }

    $Request = Invoke-WebRequest @Params -ErrorAction STOP

    if ($Request.StatusCode -eq 200) {
        $GrafanaSession.BaseUrl = $BaseUrl
        $GrafanaSession.ApiKey = $Credentials
        Write-Host "Authentication Success"
    }
}
