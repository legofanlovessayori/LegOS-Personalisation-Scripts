@echo off
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

if '%errorlevel%' NEQ '0' (
    echo Starting this script as Administrator...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params = %*:"="
    echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"

title LegOS 10 Branding Replacement Utility
:main
cls
echo --------------------------------------------------------------
echo LegOS Branding Replacement Utility
echo.
echo This Batch Script will allow you to change the Branding of
echo LegOS with ease.
echo [0] Replaces branding with the stock 10 Branding.
echo [1] Replaces Branding with the universial Branding.
echo [2] Add Version Specific Branding.
echo [3] View About info.
echo [4] Exits the App.
echo.
echo --------------------------------------------------------------

set /p branding1= Type your value here:

if /I "%branding1%" EQU "0" goto :installstock
if /I "%branding1%" EQU "1" goto :revertdefault
if /I "%branding1%" EQU "2" goto :specificbranding
if /I "%branding1%" EQU "3" goto :about
if /I "%branding1%" EQU "4" goto :exit

:about
start %windir%\ScriptsWorkingDirectory\about.hta
goto :main

:installstock
takeown /f %windir%\branding\basebrd\en-US\basebrd.dll.mui /a
copy %windir%\ScriptsWorkingDirectory\basebrd\stock.dll.mui %windir%\branding\basebrd\en-US\basebrd.dll.mui
timeout /t 5
goto :main

:revertdefault
takeown /f %windir%\branding\basebrd\en-US\basebrd.dll.mui /a
copy %windir%\ScriptsWorkingDirectory\basebrd\default.dll.mui %windir%\branding\basebrd\en-US\basebrd.dll.mui
timeout /t 5
goto :main

:exit
cls
echo --------------------------------------------------------------
echo LegOS Branding Replacement Utility
echo.
echo.
echo Exiting...
echo.
echo --------------------------------------------------------------

timeout /t 2 /nobreak
exit

:specificbranding
cls
echo --------------------------------------------------------------
echo LegOS Branding Replacement Utility
echo.
echo Here you can add Version Specific Branding from the following
echo Editions of LegOS: (Barebones, Standard and Coding Edition)
echo.
echo [0] Standard
echo [1] Barebones
echo [2] Coding Edition
echo [3] Ultimate
echo [4] Go back to the Previous Page.
echo.
echo --------------------------------------------------------------

set /p specific= Type your value here:

if /I "%specific%" EQU "0" goto :standard
if /I "%specific%" EQU "1" goto :barebones
if /I "%specific%" EQU "2" goto :codingedition
if /I "%specific%" EQU "3" goto :ultimate
if /I "%specific%" EQU "4" goto :main

:standard
takeown /f %windir%\branding\basebrd\en-US\basebrd.dll.mui /a
copy %windir%\ScriptsWorkingDirectory\basebrd\legoos10standard.dll.mui %windir%\branding\basebrd\en-US\basebrd.dll.mui 
timeout /t 5
goto :specificbranding

:barebones
takeown /f %windir%\branding\basebrd\en-US\basebrd.dll.mui /a
copy %windir%\ScriptsWorkingDirectory\basebrd\legoos10barebones.dll.mui %windir%\branding\basebrd\en-US\basebrd.dll.mui 
timeout /t 5
goto :specificbranding

:codingedition
takeown /f %windir%\branding\basebrd\en-US\basebrd.dll.mui /a
copy %windir%\ScriptsWorkingDirectory\basebrd\legoos10coding.dll.mui %windir%\branding\basebrd\en-US\basebrd.dll.mui 
timeout /t 5
goto :specificbranding

:ultimate
takeown /f %windir%\branding\basebrd\en-US\basebrd.dll.mui /a
copy %windir%\ScriptsWorkingDirectory\basebrd\legoos10ultimate.dll.mui %windir%\branding\basebrd\en-US\basebrd.dll.mui 
timeout /t 5
goto :specificbranding