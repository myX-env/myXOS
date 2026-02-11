:: ユーザー用のカスタムバッチ
@echo off
pushd "%~dp0..\.."
taskkill /f /im myXKey.exe >nul 2>&1
call User.bat
exit /b
