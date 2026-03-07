param(
    [Parameter(Mandatory=$true)]
    [ValidateSet("Add", "List", "Archive")]
    [string]$Action,

    [string]$ProjectId,
    [string]$Name,
    [string]$ManifestFile = "projects.json"
)

$projectRoot = Split-Path $PSScriptRoot -Parent
if (-not ([System.IO.Path]::IsPathRooted($ManifestFile))) {
    $ManifestFile = Join-Path $projectRoot $ManifestFile
}

if ($Action -eq "Add") {
    $newProject = @{
        id = $ProjectId
        name = $Name
        status = "active"
        created_at = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
    }

    if (Test-Path $ManifestFile) {
        $content = Get-Content $ManifestFile -Raw
        if ([string]::IsNullOrWhiteSpace($content)) {
            $projects = @($newProject)
        } else {
            $projects = @($content | ConvertFrom-Json)
            $projects += $newProject
        }
    } else {
        $projects = @($newProject)
    }

    $projects | ConvertTo-Json -Depth 10 | Out-File $ManifestFile
} elseif ($Action -eq "List") {
    if (Test-Path $ManifestFile) {
        $content = Get-Content $ManifestFile -Raw
        if ([string]::IsNullOrWhiteSpace($content)) { return @() }
        return @($content | ConvertFrom-Json)
    } else {
        return @()
    }
} elseif ($Action -eq "Archive") {
    if (Test-Path $ManifestFile) {
        $content = Get-Content $ManifestFile -Raw
        if ([string]::IsNullOrWhiteSpace($content)) { return }
        $projects = @($content | ConvertFrom-Json)
        foreach ($p in $projects) {
            if ($p.id -eq $ProjectId) {
                $p.status = "archived"
            }
        }
        $projects | ConvertTo-Json -Depth 10 | Out-File $ManifestFile
    }
}
