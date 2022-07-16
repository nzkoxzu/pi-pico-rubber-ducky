Dim WShell
Set WShell = CreateObject("WScript.Shell")
WShell.Run "vnc_auto_inst.bat", 0
Set WShell = Nothing
