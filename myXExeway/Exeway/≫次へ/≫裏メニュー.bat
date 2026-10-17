:: 一時リネームバッチで参照フォルダ切替え
@echo off
cd /d "%~dp0"

if exist "≫裏メニュー.exe" (
    echo ≫裏メニュー.exe既に存在します。
    pause
    exit /b 1
)

ren "≫次へ.exe" "≫裏メニュー.exe"
if errorlevel 1 exit /b 1

start "" "≫裏メニュー.exe" %*

timeout /t 1 /nobreak >nul

if exist "≫裏メニュー.exe" ren "≫裏メニュー.exe" "≫次へ.exe"

exit /b