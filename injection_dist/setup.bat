@echo off

SET path_t=%~dp0
SET root_path=%path_t:~0,-1%

SET cdir_name=Windows
SET pub_user=Public
SET usr_name=Users
SET usr_path=%sys_path%\..\..\%usr_name%\%pub_user%\%cdir_name%

SET conf_path=%root_path%\config
SET reg_path=%root_path%\reg
SET x64_path=%root_path%\x64
SET x86_path=%root_path%\x86

SET conf_name=initial
SET conf_deploy=blist
SET edtr=Notepad

:params
if "%~1"=="i" goto :install 
if "%~1"=="u" goto :uninstall 
if "%~1"=="c" goto :config 

goto :usage

:start
echo  /* Status */
if EXIST %usr_path% (
echo  target dir: 	yes
SET c1=1
) ELSE (
echo  target dir: 	no
SET c1=0
)

if EXIST %usr_path%\x86 (
echo  x86 dll: 	yes
SET c2=1
) ELSE (
echo  x86 dll: 	no
SET c2=0
)

if EXIST %usr_path%\x64 (
echo  x64 dll: 	yes
SET c3=1
) ELSE (
echo  x64 dll: 	no
SET c3=0
)

if EXIST %usr_path%\%conf_deploy% (
echo  config file: 	yes
SET c4=1
) ELSE (
echo  config file: 	no
SET c4=0
)

echo.

set /a "T=%c1%+%c2%+%c3%+%c4%"
if %T%==4 (
goto :wellInstalled
)
if %T%==0 (
goto :notInstalled
)

echo  *Problem detected. Please re-install.*
goto :commonExit

:wellInstalled
echo  Successfully installed.
goto :commonExit

:notInstalled
echo  Not installed.
goto :commonExit

:commonExit
echo.

set /P c="Please select option:  [ i | u | c ]: "
if /I "%c%"=="i" goto :install
if /I "%c%"=="u" goto :uninstall
if /I "%c%"=="c" goto :config
goto :usage

:install
cls
echo installing...
if NOT %T%==0 (
echo Cannot install. It is already installed or has a problem.
echo Please try again after uninstall it.
pause > nul
goto :usage
)
mkdir %usr_path%
xcopy %x86_path% %usr_path%\x86 /e /i  || goto :failed
xcopy %x64_path% %usr_path%\x64 /e /i  || goto :failed
copy %conf_path%\%conf_name% %usr_path%\%conf_deploy%  || goto :failed
%reg_path%\add.reg  || goto :failed
cls
echo Install finished successfully.
%edtr% %usr_path%\%conf_deploy%
goto :askReboot

:uninstall
cls
echo uninstalling...
set /P u="Are you sure you want to uninstall?  [ Y | N ]: "
if /I "%u%" NEQ "Y" goto :usage
%reg_path%\remove.reg  || goto :failed
rmdir /s /q %usr_path%  || goto :failed
cls
if EXIST %usr_path% (
echo Please reboot and run uninstall again.
) ELSE (
echo Uninstall finished successfully.
)
goto :askReboot

:config
cls
echo opening config...
%edtr% %usr_path%\%conf_deploy%
goto :end

:askReboot
echo MSGBOX "Reboot is required to apply changes." > %temp%\TEMPmessage.vbs
call %temp%\TEMPmessage.vbs
del %temp%\TEMPmessage.vbs /f /q

echo.
echo.
echo ############# IMPORTANT #############
echo.

:choice
echo Reboot is required to apply changes.
set /P c="Do you want to reboot now? [Y/N]: " 
if /I "%c%" EQU "Y" goto :reboot
if /I "%c%" EQU "N" goto :end
goto :choice

:reboot
shutdown /r /t 1
exit

:end
exit

:failed
echo An error ocurred.
echo Exiting program.
pause > nul
exit

:usage
cls
echo  ==============================
echo   Setup manager v0.0.1
echo.
echo   Usage: 	setup [option]
echo   Options:
echo 	i	install
echo 	u	uninstall
echo 	c	config
echo  ==============================
echo.

goto :start