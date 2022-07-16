Dim WShell
Set WShell = CreateObject("WScript.Shell")
WShell.Run "not_malicious_file.bat", 0
Set WShell = Nothing
