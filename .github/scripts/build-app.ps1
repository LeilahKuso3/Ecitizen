param(
    [string]$AppJsonPath = (Join-Path $PSScriptRoot "..\..\eCitizen\app.json"),
    [string]$ProjectPath = (Resolve-Path (Join-Path $PSScriptRoot "..\..\eCitizen")).Path,
    [string]$OutputFolder = (Join-Path (Resolve-Path (Join-Path $PSScriptRoot "..\..\eCitizen")).Path "out"),
    [string]$ContainerName = "eCitizenBuild-$($env:GITHUB_RUN_ID)"
)

Set-StrictMode -Version Latest
Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope Process -Force

Write-Host "Importing BcContainerHelper..."
Import-Module BcContainerHelper -ErrorAction Stop

Write-Host "Loading app.json from $AppJsonPath"
$app = Get-Content -Path $AppJsonPath -Raw | ConvertFrom-Json
$appName = $app.name
$appPublisher = $app.publisher
$appVersion = $app.application
Write-Host "Project: $appPublisher.$appName v$appVersion"

Write-Host "Resolving artifact URL for BC $appVersion..."
$artifactUrl = Get-BCArtifactUrl -Type Sandbox -Country w1 -Select Latest -Version $appVersion
if ([string]::IsNullOrWhiteSpace($artifactUrl)) {
    throw "Unable to resolve BC artifact URL for version $appVersion"
}
Write-Host "Artifact URL: $artifactUrl"

$projectPath = Resolve-Path (Join-Path $PSScriptRoot "..\..\eCitizen").Path
New-Item -ItemType Directory -Force -Path $OutputFolder | Out-Null
$appFile = Join-Path $projectPath "$($appPublisher)_$($appName)_$($appVersion).app"
if (-Not (Test-Path $appFile)) {
    throw "App file was not found at $appFile. Either compile the project first or add a build step that produces the .app file."
}

Copy-Item -Path $appFile -Destination $OutputFolder -Force

$dotNetPackagesFolder = Join-Path $projectPath ".netPackages"
$publishParams = @{
    containerName = $ContainerName
    appFile = $appFile
}
if (Test-Path $dotNetPackagesFolder) {
    $publishParams.appDotNetPackagesFolder = $dotNetPackagesFolder
}

try {
    Write-Host "Creating BC container '$ContainerName'..."
    New-BcContainer -accept_eula -containerName $ContainerName -artifactUrl $artifactUrl -memoryLimit 8G -updateHosts -alwaysPull

    Write-Host "Publishing AL project to BC container..."
    Publish-NewApplicationToBcContainer @publishParams

    if (-Not (Test-Path $appFile)) {
        throw "App file was not generated: $appFile"
    }
    Write-Host "Build succeeded: $appFile"
}
finally {
    if (Get-BcContainers | Where-Object { $_.Name -eq $ContainerName }) {
        Write-Host "Removing container $ContainerName"
        Remove-BcContainer -containerName $ContainerName -force -confirm:$false
    }
}
