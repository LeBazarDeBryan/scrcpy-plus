mode con: cols=16 lines=1
@echo off
chcp 65001
for /f "delims=" %%# in  ('"wmic path Win32_VideoController get CurrentHorizontalResolution,CurrentVerticalResolution /format:value"') do (
  set "%%#">nul
)
for /f "delims=" %%# in  ('"wmic path Win32_VideoController get currentrefreshrate /format:value"') do (
  set "%%#">nul
)
taskkill /f /im adb.exe
:Start
set name=Scrcpy+
set ver=v2.6.1
set creator=Félx
title %name% %ver% by %creator% - Menu
color 0a
cls
mode con: cols=50 lines=20
echo  ------------------------------------------------
echo '                                                '
echo '            %name% %ver% by %creator%              '
echo '                                                '
echo '------------------------------------------------'
echo '     GitHub.com/LeBazarDeBryan/scrcpy-plus      '
echo '------------------------------------------------'
echo '                                                '
echo '    [ Resolution ]          [ Refresh Rate ]    '
echo '                                                '
echo ' 1)      Auto                     Auto          '
echo ' 2)  1920 x 1080                   60           '
echo '                                                '
echo '                                                '
echo '                                                '
echo '                                                '
echo '------------------------------------------------'
echo ' P) Professional Mode                           '
echo '------------------------------------------------'
set /p input=' Choice: 
title %name% %ver% by %creator% - Waiting
mode con: cols=71 lines=20
cd Data
cls
echo Waiting for device.
adb wait-for-device
if %input%==1 goto Auto
if %input%==2 goto 1920x1080
if %input%==P goto Professional
if %input%==p goto Professional
exit

:Auto
title %name% %ver% by %creator% - Detecting
cls
echo Detected: %CurrentHorizontalResolution%x%CurrentVerticalResolution% and %CurrentRefreshRate%Hz
title %name% %ver% by %creator% - Mirroring
scrcpy --max-size=%CurrentHorizontalResolution% --max-fps=%CurrentRefreshRate%
taskkill /f /im adb.exe
pause
goto Start
exit

:1920x1080
cls
title %name% %ver% by %creator% - Mirroring
echo Choosed: 1920x1080 and 60Hz
scrcpy --max-size=1920 --max-fps=60
taskkill /f /im adb.exe
pause
goto Start
exit

:Professional
cls
echo Choosed: Professional Mode
adb devices
echo Write the serial of the device you want to use.
set /p serial=Serial: 
title %name% %ver% by %creator% - Mirroring
scrcpy -s %serial% && taskkill /f /im adb.exe
pause
goto Start
exit