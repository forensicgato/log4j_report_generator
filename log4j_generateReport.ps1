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
        if ($_.Contains(":-(")) {
            Write-Host "Vulnerable .jar" + $serverName
            $logInfo = $serverName + ";" + "VULN" + ";" + "$_" + ";"
            Add-Content $csv $logInfo
        }
        elseif ($_.Contains(":-|")) {
            Write-Host "Check .jar" + $serverName
            $logInfo = $serverName + ";" + "OLD" + ";" + "$_" + ";"
            Add-Content $csv $logInfo
        }
        elseif ($_.Contains(":-)")) {
            Write-Host "SAFE .jar" + $serverName
            $logInfo = $serverName + ";" + "SAFE" + ";" + "$_" + ";"
            Add-Content $csv $logInfo
        }
    }
}

# Thanks to Github Copilot for this script