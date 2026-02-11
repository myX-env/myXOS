:: 概要：裏メニュー用バイナリを起動
@echo off

:: 自身を終了するために古いプロセスを終了
taskkill /f /im myXConv.exe

:: 表示待ち（省略・調整可）
echo アプリの終了→裏メニュー起動
pause

:: ここから起動するため、このバッチファイルの場所に切替え
cd /d "%~dp0"

:: 新しいインスタンスを起動
start "" "..\myXConv.exe"

exit /b
