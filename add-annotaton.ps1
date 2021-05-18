$BaseUrl = "https://vsrm.dev.azure.com/aditrotfs/HCM%20Suite/_apis/release/"
$params = @{
    "URI"     = $BaseUrl + "deployments?definitionId=$(Release.DefinitionId)&definitionEnvironmentId=$(Release.DefinitionEnvironmentId)&latestAttemptsOnly=true&`$top=1&api-version=6.0"
    "Method"  = "Get"
    "Headers" = @{
        "Content-Type"  = "application/json"
        "Authorization" = "$(System.AccessToken)"
    }
}
$Request = Invoke-RestMethod @Params

$StartTime = $Request.value.startedOn
$EndTime = (Get-Date)

Add-Annotation -StartTime "$StartTime" -EndTime "$EndTime" -Text "$(AnnotationText)" -Tags "$(AnnotationTags)"