#############################################################
## Script to copy the data from Local hardisk to google Drive
## Transscript logs
#############################################################
###Modifing it online to see the difference ####

##### Checking the path #####################################

$Sources = Get-Content "C:\Scripts\Drive_Sync\Input.txt"
$Destination = "F:\Other computers\My Computer\Drive_Sync"
$scriptLogs = "K:\Google Drive logs\"

##### Start Logs files ######################################

$date = (Get-Date).ToString(“yyyyMMdd_HHmmss”)

Start-Transcript -Path $scriptLogs\"Logs"_$date.log


$Testpath = $Sources[0], $Sources[1], $Destination, $scriptLogs
$Testpaths = $Testpath -split ","
foreach($path in $Testpaths)
 {
  if(!(Test-path -Path $path))
    {
      $message = $path + " Is not available pls check"
      Write-Output $message
    }
break
 }

##### Starting the copy  #####################################

Foreach($Source in $Sources)
 {
 robocopy $Source $Destination /E
 }

 ##### Removing old log files ###############################

$limit = (Get-Date).AddDays(-3)

Get-ChildItem $scriptLogs -Recurse | ? { -not $_.PSIsContainer -and $_.CreationTime -lt $limit} | Remove-Item

Stop-Transcript
