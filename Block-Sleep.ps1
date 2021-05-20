#powershell.exe


# Written by: Aaron Wurthmann
#
# You the executor, runner, user accept all liability.
# This code comes with ABSOLUTELY NO WARRANTY.
# You may redistribute copies of the code under the terms of the GPL v3.
#
# --------------------------------------------------------------------------------------------
# Name: Block-Sleep.ps1
# Version: 2021.05.19.173401
# Description: Blocks system from going to sleep by sending keystroke if the specified 
#	application is running for specified period of time (in minutes).
# 
# Instructions: Run with application (program.exe/or without .exe)
# Example: .\Block-Sleep obs64.exe
#
# Tested with: Microsoft Windows [Version 10.0.19042.804], PowerShell [Version 5.1.19041.610]
#
# Arguments: AppName (Program), TotalMinutes (Default 9 hours), Keystroke (Default F15))
#
# Output: Progress and countdown written to PowerShell window.
#
# Notes:  
# --------------------------------------------------------------------------------------------



Param ([string]$AppName,[int]$TotalMinutes=540,[string]$Keystroke="{F15}")


While (($AppName -eq "") -or ($AppName -eq $null) ) {
	$AppName=Read-Host "Executable to Monitor"
}

[bool]$sendKeyLoop=$False
[bool]$mainLoop=$True
[int]$sleepSeconds=60
[int]$minuteCount=0
$AppName=$AppName.Split(".")[0]
$later=(Get-Date).AddSeconds($($sleepSeconds*$TotalMinutes))

while ($mainLoop) {
	
	$now=Get-Date
	$diff=$later-$now
	Write-Progress -Activity "Waiting for $AppName to Start untill $later" -Status "Time Remaining $("{0:hh\:mm}" -f $diff)" -PercentComplete $($minuteCount/$TotalMinutes*100)
	
	If ((Get-Process).ProcessName -contains $AppName) {$sendKeyLoop=$True}

	add-type -AssemblyName Microsoft.VisualBasic
	add-type -AssemblyName System.Windows.Forms

	While ($sendKeyLoop) {
		[System.Windows.Forms.SendKeys]::SendWait($Keystroke)
		
		$minuteCount++
		$now=Get-Date
		$diff=$later-$now
		#Write-Progress -Activity "Blocking Sleep untill $later" -Status "Time Remaining $("H:{0:hh\ 'M:'mm}" -f $diff)" -PercentComplete $($minuteCount/$TotalMinutes*100)
		Write-Progress -Activity "Blocking Sleep untill $later" -Status "Time Remaining $("{0:hh\:mm}" -f $diff)" -PercentComplete $($minuteCount/$TotalMinutes*100)

		Start-Sleep -Seconds $sleepSeconds
		
		If (((Get-Process).ProcessName -notcontains $AppName) -or ($minuteCount -ge $TotalMinutes) -or ($now -ge $later)) {
			$sendKeyLoop=$False
			$mainLoop=$False
			break
		}
	}
	
	$minuteCount++
	If (($minuteCount -ge $TotalMinutes) -or ($now -ge $later)) {
		$mainLoop=$False
		break
	}
	
	Start-Sleep -Seconds $sleepSeconds
}

