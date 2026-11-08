param(
    [Parameter(Mandatory = $true)]
    [string]$Url,

    [string]$OutputDirectory = "reports",

    [string]$Endpoint = "https://check.morphostech.com/api/check"
)

$ErrorActionPreference = "Stop"

$parsed = $null
if (-not [Uri]::TryCreate($Url, [UriKind]::Absolute, [ref]$parsed)) {
    throw "Url must be absolute."
}

if ($parsed.Scheme -notin @("http", "https")) {
    throw "Url must use http or https."
}

$resolvedOutput = [IO.Path]::GetFullPath((Join-Path (Get-Location) $OutputDirectory))
New-Item -ItemType Directory -Path $resolvedOutput -Force | Out-Null

$hostName = $parsed.Host -replace "[^A-Za-z0-9.-]", "-"
$stamp = Get-Date -Format "yyyyMMdd-HHmmss"
$outputPath = Join-Path $resolvedOutput "$hostName-$stamp.json"
$body = @{ url = $parsed.AbsoluteUri } | ConvertTo-Json -Compress

& curl.exe `
    --http1.1 `
    --location `
    --retry 2 `
    --retry-all-errors `
    --max-time 90 `
    --silent `
    --show-error `
    "$Endpoint" `
    --header "content-type: application/json" `
    --data-raw $body `
    --output $outputPath

if ($LASTEXITCODE -ne 0) {
    throw "The audit request failed with curl exit code $LASTEXITCODE."
}

$report = Get-Content -LiteralPath $outputPath -Raw | ConvertFrom-Json
if (-not $report.ok) {
    throw "The audit endpoint returned an error: $($report.error)"
}

[pscustomobject]@{
    reportId = $report.id
    requestedUrl = $Url
    finalUrl = $report.transfer.finalUrl
    overall = $report.overall
    output = $outputPath
}
