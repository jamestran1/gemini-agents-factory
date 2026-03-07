# Test Project State Manifest
$statePath = ".\src\project_state.ps1"
$manifestFile = "tests\projects.json"

if (Test-Path $manifestFile) { Remove-Item $manifestFile }

# Test: Add Project
& $statePath -Action Add -ProjectId "project_1" -Name "Weather App" -ManifestFile $manifestFile
if (Test-Path $manifestFile) {
    $content = Get-Content $manifestFile -Raw
    Write-Host "File content: $content"
    $projects = @($content | ConvertFrom-Json)
    if ($projects.Count -eq 1 -and $projects[0].id -eq "project_1") {
        Write-Host "PASS: Project added to manifest."
    } else {
        Write-Host "FAIL: Project added but content incorrect. Count=$($projects.Count)"
        exit 1
    }
} else {
    Write-Host "FAIL: Manifest file not created at $manifestFile."
    exit 1
}

# Test: List Projects
$list = @(& $statePath -Action List -ManifestFile $manifestFile)
if ($list.Count -eq 1 -and $list[0].id -eq "project_1") {
    Write-Host "PASS: List projects successful."
} else {
    Write-Host "FAIL: List projects failed. Count=$($list.Count)"
    exit 1
}

if (Test-Path $manifestFile) { Remove-Item $manifestFile }
