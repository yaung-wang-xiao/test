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
echo �����Զ�ip�밴1
echo ���ù̶�ip�밴2
echo ��ѡ��,��q�˳�
set /p shu=
if "%shu%"=="1" cls&goto ONE
if "%shu%"=="2" cls&goto TWO
if "%shu%"=="q" exit
:TWO
echo �����������Ĺ̶�IP��ַ���Եȡ���
netsh interface ip set address name="��̫��" source=static addr=172.16.75.15 mask=255.255.255.0 gateway=172.16.75.1 gwmetric=1
echo ������������DNS�����Եȡ���
netsh interface ip set dns name="��̫��" source=static addr=61.132.163.68 register=PRIMARY validate=no
netsh interface ip add dns name="��̫��" addr=10.10.10.10 validate=no
netsh interface ip set wins name="��̫��" source=static addr=none
set /p wait= ���óɹ�����������˳�
exit
:ONE
echo ���������Զ����IP��ַ�����Եȡ���
netsh interface ip set address name="��̫��" source=dhcp
netsh interface ip set dns name="��̫��" source=dhcp
set /p wait= ���óɹ�����������˳�
exit