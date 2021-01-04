$statsDir = "world\stats"
$dbFile = "UserStats.json"

function Main {
    # Load db
    $db = @{}
    $db = Get-Content $dbFile | ConvertFrom-Json -AsHashtable

    # Get statistics
    $statsFiles = Get-ChildItem $statsDir -Filter *.json
    $current = ($statsFiles | Where-Object { $_.LastWriteTime -gt (Get-Date).AddMinutes(-5) }).Count
    $totalLastHour = ($statsFiles | Where-Object { $_.LastWriteTime -gt (Get-Date).AddHours(-1) }).Count
    $totalLastDay = ($statsFiles | Where-Object { $_.LastWriteTime -gt (Get-Date).AddDays(-1) }).Count
    $totalLastWeek = ($statsFiles | Where-Object { $_.LastWriteTime -gt (Get-Date).AddDays(-7) }).Count
    $totalLastMonth = ($statsFiles | Where-Object { $_.LastWriteTime -gt (Get-Date).AddMonths(-1) }).Count
    $totalLastYear = ($statsFiles | Where-Object { $_.LastWriteTime -gt (Get-Date).AddYears(-1) }).Count
    $total = $statsFiles.Count

    # Add record
    $key = Get-DateKey (Get-Date)
    $db[$key] = $current

    # Store db
    $db | ConvertTo-Json -Compress | Out-File -FilePath $dbFile

    # Calculate statistics
    $todayKey = $key.Substring(0, 8)
    $today = $db.GetEnumerator() | Where-Object { $_.Key.StartsWith($todayKey) } | Measure-Object Value -Average -Maximum
    $yesterdayKey = (Get-DateKey (Get-Date).AddDays(-1)).Substring(0, 8)
    $yesterday = $db.GetEnumerator() | Where-Object { $_.Key.StartsWith($yesterdayKey) } | Measure-Object Value -Average -Maximum

    $weekKey = $key.Substring(0, 6)
    $week = $db.GetEnumerator() | Where-Object { $_.Key.StartsWith($weekKey) } | Measure-Object Value -Average -Maximum
    $lastWeekKey = (Get-DateKey (Get-Date).AddDays(-7)).Substring(0, 6)
    $lastWeek = $db.GetEnumerator() | Where-Object { $_.Key.StartsWith($lastWeekKey) } | Measure-Object Value -Average -Maximum

    $monthKey = $key.Substring(0, 4)
    $month = $db.GetEnumerator() | Where-Object { $_.Key.StartsWith($monthKey) } | Measure-Object Value -Average -Maximum
    $lastMonthKey = (Get-DateKey (Get-Date).AddMonths(-1)).Substring(0, 4)
    $lastMonth = $db.GetEnumerator() | Where-Object { $_.Key.StartsWith($lastMonthKey) } | Measure-Object Value -Average -Maximum

    $yearKey = $key.Substring(0, 2)
    $year = $db.GetEnumerator() | Where-Object { $_.Key.StartsWith($yearKey) } | Measure-Object Value -Average -Maximum
    $lastYearKey = (Get-DateKey (Get-Date).AddYears(-1)).Substring(0, 2)
    $lastYear = $db.GetEnumerator() | Where-Object { $_.Key.StartsWith($lastYearKey) } | Measure-Object Value -Average -Maximum

    # Output statistics
    $output = "# Total players" + [environment]::NewLine
    $output += "Current    " + $current + [environment]::NewLine
    $output += "Last hour  " + $totalLastHour + [environment]::NewLine
    $output += "Last day   " + $totalLastDay + [environment]::NewLine
    $output += "Last week  " + $totalLastWeek + [environment]::NewLine
    $output += "Last month " + $totalLastMonth + [environment]::NewLine
    $output += "Last year  " + $totalLastYear + [environment]::NewLine
    $output += "Total      " + $total + [environment]::NewLine
    $output += "" + [environment]::NewLine
    $output += "# Maximum players online" + [environment]::NewLine
    $output += "Today      " + [math]::Round($today.Maximum, 2) + " (" + [math]::Round(($today.Maximum - $yesterday.Maximum) / $yesterday.Maximum * 100) + "%)" + [environment]::NewLine
    $output += "This week  " + [math]::Round($week.Maximum , 2) + " (" + [math]::Round(($week.Maximum - $lastWeek.Maximum) / $lastWeek.Maximum * 100) + "%)" + [environment]::NewLine
    $output += "This month " + [math]::Round($month.Maximum, 2) + " (" + [math]::Round(($month.Maximum - $lastMonth.Maximum) / $lastMonth.Maximum * 100) + "%)" + [environment]::NewLine
    $output += "This year  " + [math]::Round($year.Maximum , 2) + " (" + [math]::Round(($year.Maximum - $lastYear.Maximum) / $lastYear.Maximum * 100) + "%)" + [environment]::NewLine
    $output += "" + [environment]::NewLine
    $output += "# Average players online" + [environment]::NewLine
    $output += "Today      " + [math]::Round($today.Average, 2) + " (" + [math]::Round(($today.Average - $yesterday.Average) / $yesterday.Average * 100) + "%)" + [environment]::NewLine
    $output += "This week  " + [math]::Round($week.Average , 2) + " (" + [math]::Round(($week.Average - $lastWeek.Average) / $lastWeek.Average * 100) + "%)" + [environment]::NewLine
    $output += "This month " + [math]::Round($month.Average, 2) + " (" + [math]::Round(($month.Average - $lastMonth.Average) / $lastMonth.Average * 100) + "%)" + [environment]::NewLine
    $output += "This year  " + [math]::Round($year.Average , 2) + " (" + [math]::Round(($year.Average - $lastYear.Average) / $lastYear.Average * 100) + "%)" + [environment]::NewLine

    $output | Out-File UserStats.txt
    [environment]::NewLine + $output
}

function Get-DateKey([datetime]$Date = (Get-Date)) {
    $year = $Date.Year.ToString().Substring(2)
    $month = $Date.Month.ToString().PadLeft(2, "0")
    $week = (Get-WeekNumber -DateTime $Date).ToString().PadLeft(2, "0")
    $day = $Date.Day.ToString().PadLeft(2, "0")
    $hour = $Date.Hour.ToString().PadLeft(2, "0")
    $twelfth = [math]::Ceiling($Date.Minute / 5).ToString().PadLeft(2, "0")
    $year + $month + $week + $day + $hour + $twelfth
}

function Get-WeekNumber([datetime]$DateTime = (Get-Date)) {
    $ci = [System.Globalization.CultureInfo]::CurrentCulture
    $ci.Calendar.GetWeekOfYear($DateTime, $ci.DateTimeFormat.CalendarWeekRule, $ci.DateTimeFormat.FirstDayOfWeek)
}

Main
