function Add-Annotation {
    <#
    .SYNOPSIS
        Add graph annotations to Grafana Dashboards

    .PARAMETER StartTime
        When should the annotation start, must be a Unix Epoch Timestamp

    .PARAMETER EndTime
        When should the annotation end, must be a Unix Epoch Timestamp

    .PARAMETER Tags
        Annotations must have tags, this allows you to supply as many as wanted

    .PARAMETER Text
        Descriptive text of the annotation

    .PARAMETER DashboardId
        Use this if the annotation should only apply to a specific dashboard.

    .PARAMETER PanelId
        Use this if the annotation should only apply to a specific panel.

    .EXAMPLE
        PS C:\> Add-Annotation -StartTime 1619103667 -EndTime 1619103677 -Tags "Prod" "App1" "Swarm" -Text "Deployed App1 to Swarm"

        To annotate all dashboards:

    .EXAMPLE
        PS C:\> Add-Annotation -StartTime 1619103667 -EndTime 1619103677 -Tags "Prod" "App1" "Swarm" -Text "Deployed App1 to Swarm" -DashboardId 123

        To annotate specific dashboard:

    .EXAMPLE
        PS C:\> Add-Annotation -StartTime 1619103667 -EndTime 1619103677 -Tags "Prod" "App1" "Swarm" -Text "Deployed App1 to Swarm" -DashboardId 123 -PanelId 1

        To annotate specific dashboard panel.

    .LINK
        https://grafana.com/docs/grafana/latest/http_api/annotations/#create-annotation

    #>

    [CmdletBinding()]
    param(
        [Parameter(
            Mandatory = $true
        )] [datetime] $StartTime,

        [Parameter(
            Mandatory = $false
        )] [datetime] $EndTime,

        [Parameter(
            Mandatory = $true
        )] [string[]] $Tags,

        [Parameter(
            Mandatory = $true
        )] [string] $Text,

        [Parameter(
            Mandatory = $false
        )] [int] $DashboardId,

        [Parameter(
            Mandatory = $false
        )] [int] $PanelId
    )

    $Body = @{
        dashboardId = $DashboardId
        panelId     = $PanelId
        time        = (ConvertTo-Epoch $StartTime -MilliSeconds)
        timeEnd     = if ($EndTime) { (ConvertTo-Epoch $EndTime -MilliSeconds) }
        tags        = $Tags
        text        = $Text
    }

    $Params = @{
        "URI"     = $GrafanaSession.BaseUrl + "/annotations"
        "Method"  = "Post"
        "Headers" = @{
            "Content-Type"  = "application/json"
            "Authorization" = $GrafanaSession.ApiKey
        }
        "Body"    = $Body | ConvertTo-Json
    }

    $Request = Invoke-WebRequest @Params -ErrorAction Stop
    Write-Output $Request.Content
}