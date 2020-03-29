# LTSpiceXVII Benchmark Script
# E. Sims 3/29/2020

$date = date
Write-Output 'LTSpice Benchmark'
Write-Output ''

Write-Output 'CPU info...'
Get-WmiObject -Class Win32_Processor | Select-Object -Property Name, Number*

Start-Sleep -s 1

Write-Output ''
Write-Output 'running baseline benchmark...'

$baselinetime = 0
$numberofbaselineattemps = 5
for($i = 0; $i -lt $numberofbaselineattemps; $i++)
{
    $baselinetime += (Measure-Command {cmd /c 'C:\Program Files\LTC\LTspiceXVII\XVIIx64.exe' -b -run .\NOT_A_REAL_FILE.asc}).TotalSeconds/$numberofbaselineattemps
    Start-Sleep -s 1
}
Write-Output ('average ltspice start time: ' + $baselinetime)

Write-Output ''
Start-Sleep -s 1

$files = @('.\DCopPnt.asc', '.\LT3845_TA01.asc', '.\Electrometer.asc')
$runs = @()
$totaltime = 0
foreach($file in $files)
{
    Write-Output ('Running ' + $file + '...')
    $time = (Measure-Command {cmd /c 'C:\Program Files\LTC\LTspiceXVII\XVIIx64.exe' -b -run $file}).TotalSeconds - $baselinetime
    $runs += [pscustomobject]@{'File'=$file;'ExecTime'=$time}
    $totaltime += $time
    Write-Output ('took ' + $time + ' seconds.')
    Write-Output ''
    Start-Sleep -s 1
}

Write-Output ('Total time: ' + $totaltime + ' seconds')
Write-Output ''

$logfile = 'LTSpiceBenchmarkReport.txt'
if (!(Test-Path .\$logfile))
{
    New-Item -Path . -Name $logfile -ItemType "file"
}
Add-Content -Path .\$logfile 'LTSpice Benchmark Report'
Add-Content -Path .\$logfile ($env:computername + ' ' + $date)
Get-WmiObject -Class Win32_Processor | Select-Object -Property Name, Number* | Out-File .\$logfile -Append -Encoding ASCII
Add-Content -Path .\$logfile ('LTSpice avg startup time: ' + $baselinetime + ' seconds')
$runs | Select-Object -Property File, ExecTime | Out-File .\$logfile -Append -Encoding ASCII
Add-Content -Path .\$logfile ('Total time: ' + $totaltime + ' seconds')
Add-Content -Path .\$logfile ''
Add-Content -Path .\$logfile ''


pause