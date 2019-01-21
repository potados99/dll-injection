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

:start

set /P c="Please select option:  [ i | u | c ]: "
if /I "%c%"=="i" goto :install
if /I "%c%"=="u" goto :uninstall
if /I "%c%"=="c" goto :config
cls
goto :usage

:install
echo install
mkdir %usr_path%
xcopy %x86_path% %usr_path%\x86 /e /i
xcopy %x64_path% %usr_path%\x64 /e /i
copy %conf_path%\%conf_name% %usr_path%\%conf_deploy%
%reg_path%\add.reg
 
echo Install finished.
%edtr% %usr_path%\%conf_deploy%
goto :askrb

:uninstall
echo uninstall
%reg_path%\remove.reg
del %usr_path%\%conf_deploy%
rmdir /s /q %usr_path%
echo Uninstall finished.
goto :askrb

:config
echo config
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

:usage
echo.
echo  ==========================
echo  Setup manager v0.0.1
echo.
echo  Usage: setup [option]
echo  Options:
echo 	i	install
echo 	u	uninstall
echo 	c	config
echo  ==========================
echo.

goto :start
