:: 概要：引数が.ps1形式ならPSを実行、引数なし → myXHelper.ps1 を起動
:: PowerShell 7 の場合は（pwsh）に置換え
@echo off
setlocal

:: 引数が.ps1形式ならPSを実行、引数なしなら myXHelper.ps1 を起動
set "PS_SCRIPT=%~1"
if "%PS_SCRIPT%"=="" set "PS_SCRIPT=%~dp0..\myXHelper.ps1"

:: PowerShell 5.1 固定起動
cd /d ..
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%PS_SCRIPT%"

endlocal
exit /b
