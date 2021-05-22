# Block-Sleep
Blocks system from going to sleep by sending a keystroke if the specified application is running for a specified period of time (in minutes), default is 9 hours.

## Legal:
	You the executor, runner, user accept all liability.
	This code comes with ABSOLUTELY NO WARRANTY.
	You may redistribute copies of the code under the terms of the GPL v3.
	
## Background:
I use my Windows system as a console for other systems running either Linux or macOS. One of these systems is connected via a capture card. 
I use OBS Studio as a no to low latency solution to view another system's desktop. My Windows system was constantly going to sleep because I wasn't pressing the keys on it.

## Instructions:
	  - Download Block-Sleep.ps1
	  - Open PowerShell
	  - Run with application name (program.exe/or without .exe)
Example:
```powershell
.\Block-Sleep obs64.exe
```
