:: 概要：更新（アプリの終了→再起動）
@echo off

:: 自身を終了するために古いプロセスを終了
taskkill /f /im myXConv.exe

:: 表示待ち（省略・調整可）
echo アプリの終了→再起動
pause

:: EXE パス
set "EXE=%~dp0..\..\myXConv.exe"

:: 再起動
cd /d "%~dp0.."
start "" "%EXE%"

exit /b