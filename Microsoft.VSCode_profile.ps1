# https://supportability.visualstudio.com/AzureIaaSVM/_wiki/wikis/AzureIaaSVM/495133/Powershell-Profile_RDP-SSH
# set-alias WinGuestAnalyzer "\\fsu\shares\wats\scripts\WinGuestAnalyzer\WinGuestAnalyzer.ps1" -force -ErrorAction SilentlyContinue
# Set-Alias hostanalyzer \\fsu\shares\wats\scripts\get-sub\hostanalyzer\hostanalyzer.ps1


# https://github.com/PowerShell/PSReadLine
try {
	Import-Module PSReadLine
}
catch {
	Write-Output "Skip import of PSReadline"
}
Clear-Host

# https://github.com/mattparkes/PoShFuck
try {
	Import-Module PoShFuck -ErrorAction Stop
}
catch {
	Invoke-Expression ((New-Object net.webclient).DownloadString('https://raw.githubusercontent.com/mattparkes/PoShFuck/master/Install-TheFucker.ps1'))
	Import-Module PoShFuck
}

# https://github.com/Chris--A/PowerLib/blob/main/Render-String.ps1
C:\Users\rymccall\GitHub\PowerLib\Render-String.ps1 -In "RyanMcSloMo" -FontSize 12 -FontName Calibri -FontStyle Bold

# https://github.com/chubin/wttr.in
# Invoke-RestMethod https://wttr.in/?F
function Get-Weather {
	Invoke-RestMethod 'https://wttr.in?format=🌡️ %t (Feels like %f) %c(%C) 💧%h (humidity) 💨 %w ☂️  %p'
	Invoke-RestMethod 'https://wttr.in?format=🌄 %D 🔅 %S 🎇 %z 🌆 %s 🌃 %d %m \n'
}
Get-Weather

# https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/test-toolkit
Import-Module C:\users\RYMCCALL\GitHub\arm-ttk\arm-ttk\arm-ttk.psd1

# https://github.com/rjmccallumbigl/Connect-RDPServer
. "C:\Users\rymccall\OneDrive - Microsoft\PowerShell\Connect-RDPServer.ps1"
