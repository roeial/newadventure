
$log = get-content c:\tmp\test.csv
foreach ($line in $log) { 
    if ($line -notlike "*We are under maintenance mode!*") {
$line | out-file -FilePath "C:\tmp\NonMaintenanceResults.txt" -Append
    }
}

Get-Content C:\tmp\NonMaintenanceResults.txt | Measure-Object –Line