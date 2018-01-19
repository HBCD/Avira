@echo off
title Avira
:f
echo.
echo Avira Antivirus Scaning options
echo.
echo   1. Scan of all files (Recommended)
echo   2. Deep Scan inside zip/compressed archives (Very Slow)
echo   3. Manual Scan
echo   4. Update Definitions and Run
echo   5. Update Definitions Integrate in AviraAntiVir.7z (only on USB)
echo.
:a
set /p dpscan=Choose an option : 
if "%dpscan%"=="1" goto b
if "%dpscan%"=="2" set avideep=/z /a & goto b
if "%dpscan%"=="3" goto g
if "%dpscan%"=="4" goto u
if "%dpscan%"=="5" goto u
goto a
:g
cmd.exe /k dir /w
goto z
:u
echo.
fusebundle.exe
if not exist temp\install\vdf_fusebundle.zip goto i
7z.exe x -y temp\install\vdf_fusebundle.zip
rmdir /s /q temp
echo.
if "%dpscan%"=="5" 7z.exe a AviraAntiVir.7z -x!download.exe -x!7z.* -x!scan.log -x!AviraAntiVir.7z&move /y AviraAntiVir.7z "%*\Files"
goto f
:i
echo ERROR
echo Update Failed
goto f
:b
echo.
echo What to do with infected files ?
echo.
echo   1. Clean (Recommended)
echo   2. Rename and Add .vir to the filename
echo   3. Delete file
echo   4. Ignore (Report only)
echo   5. Move to quarantine
echo   6. Ask
echo.
:c
set /p aviopt=Choose an option : 
if "%aviopt%"=="1" set aviact=clean & goto d
if "%aviopt%"=="2" set aviact=rename & goto d
if "%aviopt%"=="3" set aviact=delete & goto d
if "%aviopt%"=="4" set aviact=ignore & goto d
if "%aviopt%"=="5" set aviact=move & goto d
if "%aviopt%"=="6" set aviact=ask & goto d
goto c
:d
echo.
For %%I IN (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) DO for /f "tokens=4,6*" %%k in ('vol %%I: 2^>nul^|find "drive"') do echo %%k:\ - %%l %%m
echo.
:p
set avidrv=C:\
set /p avidrv=What to scan? (Example C:\) 
if not "%avidrv:~1,1%"==":" goto p
echo.
scancl.exe --logformat=singleline --quarantine="%avidrv:~0,2%\Quarantine" --logappend --log=scan.log --colors --heurlevel=2 --defaultaction=%aviact% --suspiciousaction=%aviact% %avideep% "%avidrv%"
start "" scan.log
Echo Done.
goto f
:z