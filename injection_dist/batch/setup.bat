@echo off

SET path_t=%~dp0
SET batch_path=%path_t:~0,-1%
SET root_path=%batch_path:~0,-6%

SET sys_path=C:\Windows\System32
SET cdir_name=Windows
SET usr_name=Users
SET usr_path=%sys_path%\..\..\%usr_name%\%cdir_name%

SET conf_path=%root_path%\config
SET dll_path=%root_path%\dll
SET reg_path=%root_path%\reg

SET target_dll=injection.dll
SET conf_name=initial
SET conf_deploy=blist
SET edtr=Notepad

if "%~1"=="install" goto :install
if "%~1"=="uninstall" goto :uninstall
if "%~1"=="config" goto :config
goto :wrongp

:install

copy %dll_path%\%target_dll% %sys_path%

mkdir %usr_path%

copy %conf_path%\%conf_name% %usr_path%\%conf_deploy%

%reg_path%\add.reg

cls

echo Install finished.

%edtr% %usr_path%\%conf_deploy%

goto :askrb

:uninstall

%reg_path%\remove.reg

del %usr_path%\%conf_deploy%

rmdir /s /q %usr_path%

del %sys_path%\%target_dll%

echo Uninstall finished.

goto :askrb

:config
%edtr% %usr_path%\%conf_deploy%
goto :n

:askrb
echo MSGBOX "Reboot is required to apply changes." > %temp%\TEMPmessage.vbs
call %temp%\TEMPmessage.vbs
del %temp%\TEMPmessage.vbs /f /q

echo.
echo.
echo ############################## IMPORTANT ###############################
echo.

:choice
set /P c=Reboot is required to apply changes. Do you want to reboot now [Y/N]? 
if /I "%c%" EQU "Y" goto :rb
if /I "%c%" EQU "N" goto :n
goto :choice

:rb
shutdown /r /t 1
exit

:n
exit

:wrongp
echo "Usage: setup [install | uninstall | config]"
pause > nul
