param(
    [Parameter(Mandatory=$true)]
    [ValidateSet("Add", "List", "Archive")]
    [string]$Action,

    [string]$ProjectId,
    [string]$Name,
    [string]$ManifestFile = "projects.json"
)

$scriptDir = $PSScriptRoot
$projectRoot = Split-Path $scriptDir -Parent
if ($env:GEMINI_EXTENSION_PATH) {
    $projectRoot = $env:GEMINI_EXTENSION_PATH
}

if (-not ([System.IO.Path]::IsPathRooted($ManifestFile))) {
    $ManifestFile = Join-Path $projectRoot $ManifestFile
}

# Helper to ensure clean array handling in PowerShell
function Write-Manifest($data) {
    # Ensure we are passing an array to ConvertTo-Json
    $json = @($data) | ConvertTo-Json -Depth 10
    $json | Out-File $ManifestFile -Encoding utf8
}

if ($Action -eq "Add") {
    $newProject = [PSCustomObject]@{
        id = $ProjectId
        name = $Name
        status = "active"
        created_at = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
    }

    $projects = @()
    if (Test-Path $ManifestFile) {
        $content = Get-Content $ManifestFile -Raw
        if (-not [string]::IsNullOrWhiteSpace($content)) {
            $parsed = $content | ConvertFrom-Json
            if ($parsed -is [array]) {
                $projects = [System.Collections.Generic.List[object]]::new($parsed)
            } else {
                $projects = [System.Collections.Generic.List[object]]::new(@($parsed))
            }
        }
    }
    
    $projects.Add($newProject)
    Write-Manifest $projects
} elseif ($Action -eq "List") {
    if (Test-Path $ManifestFile) {
        $content = Get-Content $ManifestFile -Raw
        if ([string]::IsNullOrWhiteSpace($content)) { return @() }
        $parsed = $content | ConvertFrom-Json
        return @($parsed | Where-Object { $_.id -ne $null })
    } else {
        return @()
    }
} elseif ($Action -eq "Archive") {
    if (Test-Path $ManifestFile) {
        $content = Get-Content $ManifestFile -Raw
        if ([string]::IsNullOrWhiteSpace($content)) { return }
        $parsed = $content | ConvertFrom-Json
        $projects = @($parsed | Where-Object { $_.id -ne $null })
        foreach ($p in $projects) {
            if ($p.id -eq $ProjectId) {
                $p.status = "archived"
            }
        }
        Write-Manifest $projects
    }
}
