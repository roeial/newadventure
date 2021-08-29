$activemaintenance = Test-Path -Path C:\tmp\maintenance.txt -PathType Leaf
$resultfile = 'C:\tmp\test.csv'
"Date , Message" | add-content $resultfile

$date = Get-Date
$result_running = 'Notepad is running'
$result_started = 'Notepad was started'
$result_maintanance = 'We are under maintenance mode!'


$app = 'notepad'
$minstorun = 1

while (((Get-Date)-($date)).TotalMinutes -lt $minstorun)
{
    $process = Get-Process -Name $app
    $date1 = Get-Date -Format "dd/MM/yyyy HH:mm:ss"
if ($activemaintenance)
{
    "$date1,$result_maintanance" | add-content -Path $resultfile 
    }
else
{    
if ($process -eq $null)
{
    Start-Process $app
    "$date1,$result_started" | add-content -Path $resultfile 
    }
    else
    {
         "$date1,$result_running" | add-content -Path $resultfile 
    }


    }
    Start-Sleep -seconds 5
}


$log = get-content c:\tmp\test.csv
foreach ($line in $log) { 
    if ($line -like "*We are under maintenance mode!*") {
$line | out-file -FilePath "C:\tmp\MaintenanceResults.txt" -Append
    }
}

Get-Content C:\tmp\MaintenanceResults.txt | Measure-Object –Line