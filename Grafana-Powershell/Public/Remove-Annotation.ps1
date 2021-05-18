function Remove-Annotation {
    <#
    .SYNOPSIS
        Remove annotation from Grafana

    .PARAMETER Id
        Annotation Id

    .EXAMPLE
        PS C:\> Remove-Annotation -Id 2

        Remove annotation with Id 2
    .LINK
        https://grafana.com/docs/grafana/latest/http_api/annotations/#delete-annotation-by-id

    #>
    [CmdletBinding(SupportsShouldProcess = $true)]
    param (
        [Parameter(
            Mandatory = $true
        )] [int] $Id
    )

    $Params = @{
        "URI"     = $GrafanaSession.BaseUrl + "/annotations/" + $Id
        "Method"  = "Delete"
        "Headers" = @{
            "Content-Type"  = "application/json"
            "Authorization" = $GrafanaSession.ApiKey
        }
    }

    if ($PSCmdlet.ShouldProcess($Params.URI, "Remove Annotation $Id")) {
        $Request = Invoke-WebRequest @params -UseBasicParsing -ErrorAction STOP
        Write-Output $Request.Content
    }
}