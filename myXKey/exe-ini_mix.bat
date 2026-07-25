:: myXKey.exe と settings.ini を1本化
@echo off
setlocal

set "EXE=myXKey.exe"
set "INI=settings.ini"
set "OUT=myXKey_標準.exe"
::set "OUT=myXKey_汎用.exe"
::set "OUT=myXKey_設定込み.exe"

if not exist "%EXE%" (
    echo %EXE% が見つからないのだ
    pause
    exit /b 1
)

if not exist "%INI%" (
    echo %INI% が見つからないのだ
    pause
    exit /b 1
)

echo.
echo %EXE% と %INI% を結合して
echo %OUT% を作成しますか？
echo.

choice /c YN /m "実行しますか"

if errorlevel 2 (
    echo キャンセルしたのだ
    pause
    exit /b
)

copy /b "%EXE%" + "%INI%" "%OUT%" >nul

echo.
echo 完了！
echo %OUT% を作成したのだ
pause
