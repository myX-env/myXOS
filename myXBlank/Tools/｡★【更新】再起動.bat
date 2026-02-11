:: "?"プレビューを有効化
@echo off & call ..\XB\CheckQ.bat input.txt "%~f0" & if errorlevel 1 exit /b

::=== ここから本処理 ===
:: 更新（アプリの終了→再起動）
@echo off
setlocal
cd ..

if %errorlevel%==0 (
    set "APP_NAME=myXBlank.exe"
) 

echo 対象アプリ = %APP_NAME%
echo 終了→再起動

:: 終了→再起動
taskkill /f /im "%APP_NAME%" >nul 2>&1
start "" "%APP_NAME%"

endlocal
exit /b
