::通常で余計な空白が取得される問題を修正
@echo off
setlocal enabledelayedexpansion

:: 引数を取得（ファイルパス）
set "filePath=%~1"

:: 空白や改行を防ぐため、トリム処理を実施
for /f "tokens=* delims=" %%A in ("%filePath%") do set "filePath=%%A"

:: ファイルパスをクリップボードにコピー
echo|set /p=!filePath!|clip

:: 終了メッセージ
echo File path copied to clipboard: !filePath!
echo ファイルパスをコピーしました

:: 一時停止か1秒待機
pause
:: timeout /t 1 /nobreak >nul
endlocal
exit /b
