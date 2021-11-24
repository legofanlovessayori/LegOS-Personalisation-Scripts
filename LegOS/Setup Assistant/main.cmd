@echo off
:: Code for startup routine... nothing is wrong here
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
title LegOS Setup Assistant

::OOBE Step 1 Code...
:step1
echo --------------------------------------------------------------
echo LegOS Setup Assistant
echo.
echo Thanks for choosing LegoOS 10! This Setup Assistant configures
echo LegOS for your usage / liking.
echo.
echo Press [1] to continue.
echo Press [2] to reboot.
echo --------------------------------------------------------------

set /p oobestep1= Type your value here:

if /I "%oobestep1%" EQU "1" goto :step2
if /I "%oobestep1%" EQU "2" goto :exit

:: OOBE Step 2... (Choose your look)
:step2
cls
title Choose your look!
echo --------------------------------------------------------------
echo LegOS Setup Assistant
echo.
echo How do you want LegOS to look?
echo.
echo Press [1] for normal Windows 10 Look.
::echo Press [2] for Windows Vista'ish Look. (in development)
echo Press [2] for Cairo Desktop (Shell replacement).
echo --------------------------------------------------------------

set /p oobestep2= Type your value here:

if /I "%oobestep2%" EQU "1" goto :step3
::if /I "%oobestep2%" EQU "2" goto :vista (in development)
if /I "%oobestep2%" EQU "2" goto :cairo

:cairo
title Downloading Cairo Shell...
aria2c https://github.com/cairoshell/cairoshell/releases/download/v0.4.133/CairoSetup_64bit.exe
timeout /t 5 /nobreak
title Installing Cairo Shell.... (User Interaction required)
start CairoSetup_64bit.exe
goto :step3

::vista (in development)
::title Configuring Vista'ish Desktop....
::insert registy commands here
::title Downloading 8GadgetPack
::aria2c https://8gadgetpack.net/dl_340/8GadgetPackSetup.msi
::timeout /t 5 /nobreak
::title Installing 8gadgetpack.... (User Interaction required)
::pause
::start 8GadgetPackSetup.msi
::pause
::title Trashing Extra Gadgets....
::taskkill /f /im sidebar.exe
::copy "%userprofile%\AppData\Local\Microsoft\Windows Sidebar\Gadgets\notes.gadget" "C:\program files (x86)\windows sidebar\gadgets"
::copy "%userprofile%\AppData\Local\Microsoft\Windows Sidebar\Gadgets\sidebar7.gadget" "C:\program files (x86)\windows sidebar\gadgets"
::copy "%userprofile%\AppData\Local\Microsoft\Windows Sidebar\Gadgets\MSN Weather 2_0.gadget" "C:\program files (x86)\windows sidebar\gadgets"
::copy "%userprofile%\AppData\Local\Microsoft\Windows Sidebar\Gadgets\slideshow.gadget" "C:\program files (x86)\windows sidebar\gadgets"
::copy "%userprofile%\AppData\Local\Microsoft\Windows Sidebar\Gadgets\currency.gadget" "C:\program files (x86)\windows sidebar\gadgets"
::del %userprofile%\appdata\local\clipboarder /s /q
::del "%userprofile%\AppData\Local\Microsoft\Windows Sidebar\Gadgets" /s /q
::del "%userprofile%\AppData\Local\Microsoft\Windows Sidebar\settings.ini" /s /q
::goto :step3

::OOBE Step 3 code...
:step3
cls
title Choose optional components
echo --------------------------------------------------------------
echo LegOS Setup Assistant
echo.
echo What optional components do you want installed?
echo.
echo Pick a Category.
echo.
echo [1] Browsers		 [4] Multimedia
echo [2] FTP / SSH Tools [5] OS Management
echo [3] Office			 [6] Misc 
echo --------------------------------------------------------------

set /p oobestep3= Type your value here:

if /I "%oobestep3%" EQU "1" goto :browsers
if /I "%oobestep3%" EQU "2" goto :ftp
if /I "%oobestep3%" EQU "3" goto :office
if /I "%oobestep3%" EQU "4" goto :media
if /I "%oobestep3%" EQU "5" goto :os
if /I "%oobestep3%" EQU "6" goto :misc

::Browsers Optional feature...
:browsers
cls
title Choose optional components - Category (Browsers)
echo --------------------------------------------------------------
echo LegOS Setup Assistant
echo.
echo Choose what browser you want installed!
echo.
echo.
echo.
echo [1] Ungoogled Chromium	[4] Opera
echo [2] Firefox			[5] Opera GX
echo [3] Brave			 	[6] Chrome 
echo --------------------------------------------------------------

set /p optional1= Type your value here:

if /I "%optional1%" EQU "1" goto :installchromium
if /I "%optional1%" EQU "2" goto :installfirefox
if /I "%optional1%" EQU "3" goto :installbrave
::Opera is spyware confirmed
if /I "%optional1%" EQU "4" goto :spyware
if /I "%optional1%" EQU "5" goto :spyware
::Chrome is ass
if /I "%optional1%" EQU "6" goto :lettertogoogletofixtheirbrowser

:installchromium
title Choose optional components - Installing Ungoogled Chromium
aria2c https://github.com/Nifury/ungoogled-chromium-binaries/releases/download/95.0.4638.69-1/ungoogled-chromium_95.0.4638.69-1.1_installer.exe
start ungoogled-chromium_95.0.4638.69-1.1_installer.exe
goto step3

:installfirefox
title Choose optional components - Installing Firefox
aria2c https://download.mozilla.org/?product=firefox-stub&os=win&lang=en
start Firefox Installer.exe
goto step3

:installbrave
title Choose optional components - Installing Brave
aria2c https://laptop-updates.brave.com/latest/winx64
start BraveBrowserSetup.exe
goto step3

:spyware
cls
title Choose optional components - Error
echo --------------------------------------------------------------
echo LegOS Setup Assistant
echo.
echo Critical Error!
echo.
echo Listen... should you trust a Chinese Company with your data?
echo No, so don't even try to install Opera (GX) on your pc.
echo.
echo Press [1] to go back.
echo Press [2] to bypass this warning.
echo --------------------------------------------------------------

set /p operagxisass= Type your value here:

if /I "%operagxisass%" EQU "1" goto :step3
if /I "%operagxisass%" equ "2" goto :installvivaldi

::Opera Fanboy's be like: L E T  M E  U S E  O P E R A 
:installvivaldi
cls
title Choose optional components - Error
echo --------------------------------------------------------------
echo LegOS Setup Assistant
echo.
echo Critical Error!
echo.
echo.
echo Come on, why are you gonna use Opera. You know what, ima give
echo you something else thats pretty close to Opera :)
echo --------------------------------------------------------------
title Choose optional components - Installing Vivaldi
aria2c https://downloads.vivaldi.com/stable/Vivaldi.4.3.2439.65.x64.exe
start Vivaldi.4.3.2439.65.x64.exe
goto step3

:lettertogoogletofixtheirbrowser
cls
title Choose optional components - Error
echo --------------------------------------------------------------
echo LegOS Setup Assistant
echo.
echo Critical Error!
echo.
echo Listen... Chrome is ass, don't use it please. If you realy 
echo want the Chrome experience, pick Ungoogled Chromium.
echo Press [1] to go back.
echo --------------------------------------------------------------
::Piderman be like: U S E C H R O M E O R D I E

set /I chromeisass= Type your value here:

if /I "%chromeisass%" equ "1" goto :browsers
::the end... finaly


::FTP / SSH Tools Category (haha putty go brrrr)
:ftp
cls
title Choose optional components - Category (FTP / SSH Tools)
echo --------------------------------------------------------------
echo LegOS Setup Assistant
echo.
echo Choose what ftp / ssh tools you want installed!
echo.
echo.
echo.
echo [1] PuTTY				
echo [2] WinSCP				
echo [3] FileZilla		 	
echo --------------------------------------------------------------

set /p optional2= Type your value here:

if /I "%optional2%" EQU "1" goto :installputty
if /I "%optional2%" EQU "2" goto :installwinscp
if /I "%optional2%" EQU "3" goto :installfilezilla

:installputty
title Choose optional components - Installing PuTTY
aria2c https://the.earth.li/~sgtatham/putty/latest/w64/putty-64bit-0.76-installer.msi
start putty-64bit-0.76-installer.msi
goto :ftp

:installwinscp
title Choose optional components - Installing WinSCP
aria2c https://winscp.net/download/files/20211124194197522c5872b63ccf3df5ceabda8b343e/WinSCP-5.19.4-Setup.exe
start WinSCP-5.19.4-Setup.exe
goto step3
:installfilezilla
title Choose optional components - Installing FileZilla
aria2c https://dl1.cdn.filezilla-project.org/client/FileZilla_3.56.2_win64-setup.exe?h=JI3Pn78mBvDYCx_LMNCiEQ&x=1637784606
start FileZilla_3.56.2_win64-setup.exe
:office

:media

:os

:misc

::OOBE Reboot Code... just in case someone thinks that rebooting is smart (currently buggy thats why commented out)
::exit
::echo --------------------------------------------------------------
::echo LegOS Setup Assistant
::echo.
::echo Are you sure to restart the PC?
::echo.
::echo Press [1] to restart.
::echo Press [2] to go back to the previous screen.
::echo --------------------------------------------------------------

::set /p ooberestart= Type your value here:

::if /I "%ooberestart%" EQU "1" goto :reboot
::if /I "%ooberestart%" EQU "2" goto :step1

::reboot
::title Setup is restarting your PC..
::cls
::reg import %windir%\scriptsworkingdirectory\setup\registry\error.reg /reg:32
::shutdown /r /t 3
::exit