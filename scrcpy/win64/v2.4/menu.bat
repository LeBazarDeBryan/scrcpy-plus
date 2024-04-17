mode con: cols=16 lines=1
@echo off
chcp 65001
set name=Scrcpy+
set ver=v2.4
set creator=JustFélix_
for /f "delims=" %%# in  ('"wmic path Win32_VideoController get CurrentHorizontalResolution,CurrentVerticalResolution /format:value"') do (
  set "%%#">nul
)
for /f "delims=" %%# in  ('"wmic path Win32_VideoController get currentrefreshrate /format:value"') do (
  set "%%#">nul
)
taskkill /f /im adb.exe
:Start
title %name% %ver% - Menu
color a
cls
mode con: cols=50 lines=20
echo  ------------------------------------------------
echo '                                                '
echo '           %name% %ver% by %creator%           '
echo '                                                '
echo '------------------------------------------------'
echo '     GitHub.com/LeBazarDeBryan/scrcpy-plus      '
echo '------------------------------------------------'
echo '                                                '
echo '    [ Resolution ]          [ Refresh Rate ]    '
echo '                                                '
echo ' 1)      Auto                     Auto          '
echo ' 2)   1920x1080                    60           '
echo '                                                '
echo '                                                '
echo '                                                '
echo '                                                '
echo '                                                '
echo '                                                '
echo '------------------------------------------------'
set /p input=' Choice: 
cd Data
title %name% %ver% - Mirroring
mode con: cols=71 lines=20
cls
echo Waiting for device.
adb wait-for-device
if %input%==1 echo Detected: %CurrentHorizontalResolution%x%CurrentVerticalResolution% and %CurrentRefreshRate%Hz && scrcpy --max-size=%CurrentHorizontalResolution% --max-fps=%CurrentRefreshRate% && taskkill /f /im adb.exe && pause && goto Start
if %input%==2 echo Choosed: 1920x1080 and 60Hz && scrcpy --max-size=1920 --max-fps=60 && taskkill /f /im adb.exe && pause && goto Start
exit