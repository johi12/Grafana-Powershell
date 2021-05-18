function Edit-Annotation {
    <#
    .SYNOPSIS
        Edit graph annotations by Id, use this if you want to just alter one field
        in an annotation

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
        PS C:\> Edit-Annotation -Id 1 -Text "Deployed App2 to swarm"

        To update annotation with id 1

    .LINK
        https://grafana.com/docs/grafana/latest/http_api/annotations/#patch-annotation
    #>

    [CmdletBinding(SupportsShouldProcess = $true)]
    param(
        [Parameter(Mandatory = $false)] [datetime] $StartTime,

        [Parameter(
            Mandatory = $false
        )] [datetime] $EndTime,

        [Parameter(
            Mandatory = $false
        )] [string[]] $Tags,

        [Parameter(
            Mandatory = $false
        )] [string] $Text,

        [Parameter(
            Mandatory = $true
        )] [int] $Id
    )

    $Body = @{
        time    = if ($StartTime) { (ConvertTo-Epoch $StartTime -MilliSeconds) }
        timeEnd = if ($EndTime) { (ConvertTo-Epoch $EndTime -MilliSeconds) }
        tags    = $Tags
        text    = $Text
    }

    $Params = @{
        "URI"     = $GrafanaSession.BaseUrl + "/annotations/" + $Id
        "Method"  = "Patch"
        "Headers" = @{
            "Content-Type"  = "application/json"
            "Authorization" = $GrafanaSession.ApiKey
        }
        "Body"    = $Body | ConvertTo-Json
    }

    if ($PSCmdlet.ShouldProcess($Params.URI, "Update Annotation $Id")) {
        $Request = Invoke-WebRequest @params -UseBasicParsing -ErrorAction STOP
        Write-Output $Request.Content
    }
}