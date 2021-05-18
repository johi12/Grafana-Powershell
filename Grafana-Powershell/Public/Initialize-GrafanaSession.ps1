function Initialize-GrafanaSession {
    <#
    .SYNOPSIS
        Adds authencation and timezone information to script variables

        You can choose either username and password (Basic Auth) or API key (Bearer token)

        UTC Offset is by default that of the scripts executing enviroment.

    .PARAMETER BaseUrl
        Grafana base Url

    .PARAMETER APIKey
        API key generated in Grafana.

    .EXAMPLE
        PS C:\> Initialize-GrafanaSession -APIKey "123sad1231231123213ex==" -UtcOffset 2

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
        )] [string] $APIKey,
        [Parameter(
            Mandatory = $false
        )] [int] $UtcOffset = ([datetimeoffset]::Now).Offset.TotalHours
    )

    $BaseUrl = $BaseUrl.Trim("/")
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

    $Request = Invoke-WebRequest @Params -UseBasicParsing -ErrorAction STOP

    Write-Output "Setting UTC offset to $UtcOffset"
    $GrafanaSession.UtcOffset = $UtcOffset


    if ($Request.StatusCode -eq 200) {
        $GrafanaSession.BaseUrl = $BaseUrl
        $GrafanaSession.ApiKey = $Credentials
        Write-Output "Authentication Success"
    }


}
