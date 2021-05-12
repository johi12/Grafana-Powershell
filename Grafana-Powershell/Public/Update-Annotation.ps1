function Update-Annotation {
    <#
    .SYNOPSIS
        Update graph annotations by Id

    .PARAMETER StartTime
        When should the annotation start, must be a Unix Epoch Timestamp

    .PARAMETER EndTime
        When should the annotation end, must be a Unix Epoch Timestamp

    .PARAMETER Tags
        Annotations must have tags, this allows you to supply as many as wanted

    .PARAMETER Text
        Descriptive text of the annotation

    .PARAMETER Id
        Id number of annotation to update

    .EXAMPLE
        PS C:\> Update-Annotation -Id 1 -StartTime 1619103667 -EndTime 1619103677 -Tags "Prod" "App1" "Swarm" -Text "Deployed App1 to Swarm"

        To update annotation with id 1

    .LINK
        https://grafana.com/docs/grafana/latest/http_api/annotations/#update-annotation

    #>

    [CmdletBinding(SupportsShouldProcess = $true)]
    param(
        [Parameter(Mandatory = $true)] [datetime] $StartTime,

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
            Mandatory = $true
        )] [int] $Id
    )

    $Body = @{
        time    = (ConvertTo-Epoch $StartTime -MilliSeconds)
        timeEnd = if ($EndTime) {
            (ConvertTo-Epoch $EndTime -MilliSeconds)
        }
        else {
            ConvertTo-Epoch $StartTime -MilliSeconds
        }
        tags    = $Tags
        text    = $Text
    }

    $Params = @{
        "URI"     = $GrafanaSession.BaseUrl + "/annotations/" + $Id
        "Method"  = "Put"
        "Headers" = @{
            "Content-Type"  = "application/json"
            "Authorization" = $GrafanaSession.ApiKey
        }
        "Body"    = $Body | ConvertTo-Json
    }

    if ($PSCmdlet.ShouldProcess($Params.URI, "Update Annotation $Id")) {
        $Request = Invoke-WebRequest @Params -ErrorAction STOP
        Write-Output $Request.Content
    }
}