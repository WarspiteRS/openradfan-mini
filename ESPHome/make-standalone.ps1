$inputFile = "openradfan-controller.yaml"
$outputFile = "openradfan-controller-standalone.yaml"

$inDashboardBlock = $false

Get-Content $inputFile | ForEach-Object {
    $line = $_

    if ($line -match '^\s*api:\s*$') {
        "# $line"
    }
    elseif ($line -match '^\s*dashboard_import:\s*$') {
        $inDashboardBlock = $true
        "# $line"
    }
    elseif ($inDashboardBlock) {
        if ($line -match '^\s{2,}[^:]') {
            "# $line"
        } elseif ($line -notmatch '^\s') {
            $inDashboardBlock = $false
            $line
        } else {
            "# $line"
        }
    }
    else {
        $line
    }
} | Set-Content $outputFile
