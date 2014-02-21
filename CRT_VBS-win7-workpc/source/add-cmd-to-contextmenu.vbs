Set WshShell=CreateObject("Wscript.Shell")  
WshShell.RegWrite "HKEY_LOCAL_MACHINE\Software\CLASSES\Folder\shell\cmd here\",""  
WshShell.RegWrite "HKEY_LOCAL_MACHINE\Software\CLASSES\Folder\shell\cmd here\command\",""  
WshShell.RegWrite "HKEY_LOCAL_MACHINE\Software\CLASSES\Folder\shell\cmd here\command\","c:\windows\system32\cmd.exe /K CD %1","REG_SZ"  
wscript.echo "²Ù×÷³É¹¦"  
set WshShell=nothing