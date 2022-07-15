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
del "tighvnc.msi"

REM DL and autoinstall node for noVNC

curl.exe --output node.msi --url https://nodejs.org/dist/v16.16.0/node-v16.16.0-x64.msi
msiexec.exe /i node.msi /qn
del "node.msi"

REM Create websockify file

touch websockify.js
echo var websockify = require('node-websockify'); > websockify.js
echo websockify({ >> websockify.js
echo source: '0.0.0.0:8000', >> websockify.js
echo target: '%LANIP%:5900' >> websockify.js
echo }); >> websockify.js


touch npm_websockify.bat
echo npm install --save node-websockify > npm_websockify.bat 
START npm_websockify.bat
timeout 5
node websockify.js

pause