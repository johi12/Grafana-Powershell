@{
    RootModule           = 'Grafana-Powershell.psm1'

    Author               = 'Jonas Hinderson <jonas.hinderson@protonmail.com>'

    ModuleVersion        = '0.0.1'
    GUID                 = '6af5974b-15b6-4724-9313-e5ac468dfd76'

    Copyright            = '2021 Jonas Hinderson'

    Description          = 'Allows you to interact with Grafanas HTTP API'

    PowerShellVersion    = '7.1'

    CompatiblePSEditions = @('Desktop', 'Core')

    # Which PowerShell functions are exported from your module? (eg. Get-CoolObject)
    FunctionsToExport    = @('Initialize-GrafanaSession', 'Add-Annotation', 'Remove-Annotation', 'Edit-Annotation', 'Update-Annotation')

    # Which PowerShell aliases are exported from your module? (eg. gco)
    AliasesToExport      = @('')

    # Which PowerShell variables are exported from your module? (eg. Fruits, Vegetables)
    VariablesToExport    = @('')

    # PowerShell Gallery: Define your module's metadata
    PrivateData          = @{
        PSData = @{
            # What keywords represent your PowerShell module? (eg. cloud, tools, framework, vendor)
            Tags       = @('Grafana', 'tools', 'annotations')

            # What software license is your code being released under? (see https://opensource.org/licenses)
            LicenseUri = 'https://opensource.org/licenses/Apache-2.0'
        }
    }
}