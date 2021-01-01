$statsDir = "world\stats"
$dbFile = "UserStats.json"

# Load db (as hashtable)
$db = @{}
(Get-Content $dbFile | ConvertFrom-Json).psobject.properties | ForEach-Object { $db[$_.Name] = $_.Value }

# Get statistics
$statsFiles = Get-ChildItem $statsDir -Filter *.json

$current = ($statsFiles | Where-Object {$_.LastWriteTime -gt (Get-Date).AddMinutes(-5)}).Count
$hour    = ($statsFiles | Where-Object {$_.LastWriteTime -gt (Get-Date).AddHours(-1)  }).Count
$total   = $statsFiles.Count

$stats = @{}
$stats.Day   = ($statsFiles | Where-Object {$_.LastWriteTime -gt (Get-Date).AddDays(-1)  }).Count
$stats.Week  = ($statsFiles | Where-Object {$_.LastWriteTime -gt (Get-Date).AddDays(-7)  }).Count
$stats.Month = ($statsFiles | Where-Object {$_.LastWriteTime -gt (Get-Date).AddMonths(-1)}).Count
$stats.Year  = ($statsFiles | Where-Object {$_.LastWriteTime -gt (Get-Date).AddYears(-1) }).Count

$averageDay   = [math]::Round(($db.AverageDay   *    287 + $current) /    288, 10)
$averageWeek  = [math]::Round(($db.AverageWeek  *   2015 + $current) /   2016, 10)
$averageMonth = [math]::Round(($db.AverageMonth *   8639 + $current) /   8640, 10)
$averageYear  = [math]::Round(($db.AverageYear  * 103679 + $current) / 103680, 10)

# Update db
$db.Current      = $current
$db.Hour         = $hour
$db.Total        = $total
$db.AverageDay   = $averageDay
$db.AverageWeek  = $averageWeek
$db.AverageMonth = $averageMonth
$db.AverageYear  = $averageYear
$date = (Get-Date).AddMinutes(-1).ToShortDateString()
$db.Remove($date)
$db[$date] = $stats

# Store db
$db | ConvertTo-Json -Compress | Out-File -FilePath $dbFile

# Output statistics
"Current:       " + $current
"Hour:          " + $hour
"Day:           " + $stats.Day
"Week:          " + $stats.Week
"Month:         " + $stats.Month
"Year:          " + $stats.Year
"Total:         " + $total
"Average Day:   " + [math]::Round($averageDay  , 3)
"Average Week:  " + [math]::Round($averageWeek , 3)
"Average Month: " + [math]::Round($averageMonth, 3)
"Average Year:  " + [math]::Round($averageYear , 3)
