@echo off
:: BatchGotAdmin
:-------------------------------------
REM --> Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
goto UACPrompt
) else ( goto gotAdmin )
:UACPrompt
echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"
"%temp%\getadmin.vbs"
exit /B
:gotAdmin
if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )
pushd "%CD%"
CD /D "%~dp0"
:--------------------------------------
echo 设置自动ip请按1
echo 设置固定ip请按2
echo 请选择,或按q退出
set /p shu=
if "%shu%"=="1" cls&goto ONE
if "%shu%"=="2" cls&goto TWO
if "%shu%"=="q" exit
:TWO
echo 正在设置您的固定IP地址请稍等……
netsh interface ip set address name="以太网" source=static addr=172.16.75.15 mask=255.255.255.0 gateway=172.16.75.1 gwmetric=1
echo 正在设置您的DNS，请稍等……
netsh interface ip set dns name="以太网" source=static addr=61.132.163.68 register=PRIMARY validate=no
netsh interface ip add dns name="以太网" addr=10.10.10.10 validate=no
netsh interface ip set wins name="以太网" source=static addr=none
set /p wait= 设置成功，按任意键退出
exit
:ONE
echo 正在设置自动获得IP地址，请稍等……
netsh interface ip set address name="以太网" source=dhcp
netsh interface ip set dns name="以太网" source=dhcp
set /p wait= 设置成功，按任意键退出
exit