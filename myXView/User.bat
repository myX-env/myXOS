:: 引数起動と通常からも分岐バッチ
:: 起動例＞User.bat XE … 中継EXE
@echo off
:: 引数チェック
if "%~1"=="" goto :NORMAL
if /i "%~1"=="SW" goto :MODE_SW
if /i "%~1"=="XB" goto :MODE_XB
if /i "%~1"=="XE" goto :MODE_XE
if /i "%~1"=="CM" goto :MODE_CMD
if /i "%~1"=="CMD" goto :MODE_CMD
if /i "%~1"=="PS" goto :MODE_PS
if /i "%~1"=="EX" goto :MODE_EX

:: ユーザー非常口（無害）
:MODE_EX
dir & pause
goto :eof

:: 切替え（_User.bat ⇔ _User+.bat）
:MODE_SW
call _User.bat >nul 2>&1 || call _User+.bat
goto :eof

:: 引数がXB→変換BOX_空箱
:MODE_XB
pushd "%~dp0..\myXBlank"
call XB.bat %*
popd
goto :eof

:: 引数がXE→中継EXE
:MODE_XE
pushd "%~dp0..\myXExeway"
start "" /b Exeway.exe %*
popd
goto :eof

:: 引数がCM/CMD→CMD
:MODE_CMD
start C:\Windows\System32\cmd.exe
goto :eof

:: 引数がPS→PowerShell
:MODE_PS
C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -NoLogo -NoProfile
goto :eof

:NORMAL

setlocal
cd /d "%~dp0"

if exist "_User.bat" (
    call "_User.bat"
) else if exist "%~dp0..\myXAppBAT\menu.bat" (
    call "%~dp0..\myXAppBAT\menu.bat"
) else (
    call "%~dp0..\myXAppBAT\myXFull.bat"
)
exit /b

@HELP_START@
** Option >> SW XB XE CM CMD PS EX 
  User.bat SW   : _User.bat <=> _User+.bat
  User.bat XB   : myXBlank
  User.bat XE   : myXExeway
  User.bat CM   : CMD
  User.bat CMD  : CMD
  User.bat PS   : PowerShell
  User.bat EX   : Edit & Free 
@HELP_END@
