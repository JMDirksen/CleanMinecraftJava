$statsDir = "world\stats"
$dbFile = "UserStats.json"

# Load db (as hashtable)
$db = @{}
(Get-Content $dbFile | ConvertFrom-Json).psobject.properties | ForEach-Object { $db[$_.Name] = $_.Value }

# Get statistics
$statsFiles = Get-ChildItem $statsDir -Filter *.json

$current = ($statsFiles | Where-Object {$_.LastWriteTime -gt (Get-Date).AddMinutes(-5)}).Count
$hour = ($statsFiles | Where-Object {$_.LastWriteTime -gt (Get-Date).AddHours(-1)}).Count
$total = $statsFiles.Count

$stats = @{}
$stats.Day = ($statsFiles | Where-Object {$_.LastWriteTime -gt (Get-Date).AddDays(-1)}).Count
$stats.Week = ($statsFiles | Where-Object {$_.LastWriteTime -gt (Get-Date).AddDays(-7)}).Count
$stats.Month = ($statsFiles | Where-Object {$_.LastWriteTime -gt (Get-Date).AddMonths(-1)}).Count
$stats.Year = ($statsFiles | Where-Object {$_.LastWriteTime -gt (Get-Date).AddYears(-1)}).Count

# Update db
$db.Current = $current
$db.Hour = $hour
$db.Total = $total
$date = (Get-Date).AddMinutes(-1).ToShortDateString()
$db.Remove($date)
$db[$date] = $stats

# Store db
$db | ConvertTo-Json -Compress | Out-File -FilePath $dbFile

# Output statistics
"Current: " + $current
"Hour:    " + $hour
"Day:     " + $stats.Day
"Week:    " + $stats.Week
"Month:   " + $stats.Month
"Year:    " + $stats.Year
"Total:   " + $total
