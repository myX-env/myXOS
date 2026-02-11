:: 概要：裏面から抜けて通常起動（前提：XGate48フォルダ内に存在）
@echo off

:: 自身を終了するために古いプロセスを終了
taskkill /f /im myXConv.exe

:: 表示待ち（省略・調整可）
echo アプリの終了→通常起動
pause

:: 2階層戻り
cd /d "%~dp0\..\.."

:: 新しいインスタンスを起動
start "" "myXConv.exe"

exit /b