$logLocation = ".\logs"
$logs = @()
$lines = @()
$logInfo
$serverName
$logs = gci($logLocation)

New-Item .\log4j_report.csv -type File -force

$csv = ".\log4j_report.csv"

Add-Content $csv "Server;PRIO;Path"

$logs | ForEach-Object {
    $lines = Get-Content $_.FullName
    $serverName = $_.Basename
    $lines | ForEach-Object {
        if ($_.Contains("_VULNERABLE_")) {
            Write-Host "Vulnerable .jar" + $serverName
            $logInfo = $serverName + ";" + "VULN" + ";" + "$_" + ";"
            Add-Content $csv $logInfo
        }
        elseif ($_.Contains("_OLD_")) {
            Write-Host "Check .jar" + $serverName
            $logInfo = $serverName + ";" + "OLD" + ";" + "$_" + ";"
            Add-Content $csv $logInfo
        }
        elseif ($_.Contains("_SAFE_")) {
            Write-Host "safe .jar" + $serverName
            $logInfo = $serverName + ";" + "SAFE" + ";" + "$_" + ";"
            Add-Content $csv $logInfo
        }
        elseif ($_.Contains("_OKAY_")) {
            Write-Host "okay .jar" + $serverName
            $logInfo = $serverName + ";" + "OKAY" + ";" + "$_" + ";"
            Add-Content $csv $logInfo
        }
        elseif ($_.Contains("_POTENTIALLY_SAFE_")) {
            Write-Host "potentially safe .jar" + $serverName
            $logInfo = $serverName + ";" + "PSAFE" + ";" + "$_" + ";"
            Add-Content $csv $logInfo
        }
    }
}

# Thanks to Github Copilot for this script