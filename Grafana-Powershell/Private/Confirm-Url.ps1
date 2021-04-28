function Confirm-Url {
    <#
    .SYNOPSIS
        Small helper to check if a URL is valid or not

    .PARAMETER Url
        A string that hopefully contains a valid URL

    .EXAMPLE
        PS C:\> Confirm-Url "https://www.google.se"

        Verify that a URL is valid

    #>
    param (
        [Parameter(
            Mandatory = $true
        )] [string] $Url

    )
    $Request = Invoke-WebRequest $Url

    if ($Request.StatusDescription -eq "OK") {
        return $true
    }
    return $false
}
