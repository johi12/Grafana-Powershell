function ConvertTo-Epoch {
    <#
    .SYNOPSIS
        Converts DateTime ojbect to the Unix Epoch Time format in milliseconds
        E.g. milliseconds gone by since 1970-01-01

        Why MilliSeconds and not seoncds? Because grafana, that's why.

    .PARAMETER Date
        A date

    .EXAMPLE
        PS C:\> ConvertTo-Epoch "2021-02-02 10:00:00"
    #>

    [CmdletBinding()]
    [OutputType([int64])]
    param (
        [Parameter(
            Mandatory = $true
        )] [datetime]$Date,
        [Parameter(
            Mandatory = $false
        )] [Switch] $MilliSeconds,
        [Parameter(
            Mandatory = $false
        )] [int] $UtcOffset = $GrafanaSession.UtcOffset
    )

    $Unit = if ($MilliSeconds) {
        "TotalMilliseconds"
    }
    else {
        "TotalSeconds"
    }

    $Epoch = (Get-Date -Date "1970-01-01 00:00:00Z").ToUniversalTime().AddHours($UtcOffset)
    $Result = [int64](New-TimeSpan -Start $Epoch -End $Date).$Unit

    return $Result
}