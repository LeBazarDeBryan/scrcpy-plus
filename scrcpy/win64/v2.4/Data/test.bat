@echo off
for /f "delims=" %%# in  ('"adb devices /format:value"') do (
  set "%%#">nul
)
echo %CurrentRefreshRate%
pause