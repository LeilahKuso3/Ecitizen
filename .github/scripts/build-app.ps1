param(
    [string]$ProjectPath = (Resolve-Path (Join-Path $PSScriptRoot "..\..\eCitizen")).Path,
    [string]$OutputFolder = (Join-Path (Resolve-Path (Join-Path $PSScriptRoot "..\..\eCitizen")).Path "out")
)

Set-StrictMode -Version Latest
Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope Process -Force

if (-not (Test-Path $ProjectPath)) {
    throw "Project path not found: $ProjectPath"
}

$AppJsonPath = Join-Path $ProjectPath "app.json"
if (-not (Test-Path $AppJsonPath)) {
    throw "app.json not found at $AppJsonPath"
}

Write-Host "Loading app.json from $AppJsonPath"
$app = Get-Content -Path $AppJsonPath -Raw | ConvertFrom-Json
$appName = $app.name
$appPublisher = $app.publisher
$appVersion = $app.version
Write-Host "Project: $appPublisher.$appName v$appVersion"

$packagesFolder = Join-Path $ProjectPath ".alpackages"
if (-not (Test-Path $packagesFolder)) {
    throw "Symbol folder not found: $packagesFolder. Add your .alpackages folder or download symbols before building."
}

Write-Host "Searching for AL compiler in VS Code extension folder..."
$extensionsFolder = Join-Path $env:USERPROFILE ".vscode\extensions"
if (-not (Test-Path $extensionsFolder)) {
    throw "VS Code extensions folder not found: $extensionsFolder. Install the AL Language extension first."
}

$alcPaths = Get-ChildItem -Path $extensionsFolder -Directory -Filter "ms-dynamics-smb.al*" -ErrorAction SilentlyContinue |
    Sort-Object Name -Descending | ForEach-Object { Join-Path $_.FullName "bin\alc.exe" }

$alcPath = $alcPaths | Where-Object { Test-Path $_ } | Select-Object -First 1
if (-not $alcPath) {
    throw "AL compiler not found in VS Code extension folder. Install the AL Language extension in VS Code."
}

Write-Host "Using AL compiler: $alcPath"
New-Item -ItemType Directory -Force -Path $OutputFolder | Out-Null
$appFile = Join-Path $OutputFolder "$($appPublisher)_$($appName)_$($appVersion).app"

Write-Host "Compiling project from $ProjectPath to $appFile"
& $alcPath /project:$ProjectPath /out:$appFile /packagecachepath:$packagesFolder
if ($LASTEXITCODE -ne 0) {
    throw "AL compilation failed with exit code $LASTEXITCODE"
}

if (-not (Test-Path $appFile)) {
    throw "Compiled app was not generated: $appFile"
}

Write-Host "Build succeeded: $appFile"
