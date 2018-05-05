powershell.exe -Command "& { Set-NetConnectionProfile -InterfaceAlias Ethernet -NetworkCategory Private }"
reg ADD HKLM\SYSTEM\CurrentControlSet\Control\Network\NewNetworkWindowOff /f