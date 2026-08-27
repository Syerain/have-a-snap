<#
.SYNOPSIS
    Timer with double audible alert – waits N seconds then beeps twice.
.DESCRIPTION
    Accepts a positive integer (seconds) as the delay. After the time elapses,
    the console emits two beeps with a short pause between them, shows a message, and exits.
.PARAMETER Seconds
    Required. The number of seconds to wait. Must be a positive integer.
.EXAMPLE
    .\Timer.ps1 -Seconds 10
    Waits 10 seconds and then beeps twice.
#>

param(
    [Parameter(Mandatory=$true, HelpMessage="Enter the number of seconds to wait (positive integer)")]
    [int]$Seconds
)

# Validate positive input
if ($Seconds -le 0) {
    Write-Error "Seconds must be a positive integer."
    exit 1
}

Write-Host "Timer started. will alert after $Seconds second(s)..." -ForegroundColor Cyan

# Wait for the specified duration
Start-Sleep -Seconds $Seconds

# Emit two beeps with a short interval
try {
    [System.Console]::Beep(1000, 200)   # First beep: 1000Hz, 200ms
    Start-Sleep -Milliseconds 300       # Interval between beeps
    [System.Console]::Beep(1000, 200)   # Second beep
} catch {
    # Fallback to bell character if Beep() is not available
    Write-Host "`a" -NoNewline
    Start-Sleep -Milliseconds 300
    Write-Host "`a" -NoNewline
}

Write-Host "`nTime's up! Script ending." -ForegroundColor Yellow

# Script exits automatically
