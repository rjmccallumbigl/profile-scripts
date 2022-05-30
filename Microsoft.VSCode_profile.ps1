# https://github.com/PowerShell/PSReadLine
try{ 
	Import-Module PSReadLine
} catch {
	Write-Output "Skip import of PSReadline"
}
Clear-Host

# https://github.com/mattparkes/PoShFuck
try {
	Import-Module PoShFuck
}
catch {
	Set-ExecutionPolicy RemoteSigned
	Invoke-Expression ((New-Object net.webclient).DownloadString('https://raw.githubusercontent.com/mattparkes/PoShFuck/master/Install-TheFucker.ps1'))
	Import-Module PoShFuck
}

# https://github.com/Chris--A/PowerLib/blob/main/Render-String.ps1
C:\Users\Ryan\Documents\GitHub\PowerLib\Render-String.ps1 -In "RyanMcSloMo" -FontSize 12 -FontName Calibri -FontStyle Bold

# https://github.com/chubin/wttr.in
# Invoke-RestMethod https://wttr.in/?F
Invoke-RestMethod 'https://wttr.in?format=🌡️ %t (Feels like %f) %c(%C) 💧%h (humidity) 💨 %w ☂️  %p'
Invoke-RestMethod 'https://wttr.in?format=🌄 %D 🔅 %S 🎇 %z 🌆 %s 🌃 %d %m \n'
