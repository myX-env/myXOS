:: myXKey.exe と settings.cmd を1本化
@echo off
setlocal

set "EXE=myXKey.exe"
set "CMD=settings.cmd"
set "OUT=myXKey_標準.exe"
::set "OUT=myXKey_汎用.exe"
::set "OUT=myXKey_設定込み.exe"

if not exist "%EXE%" (
    echo %EXE% が見つからないのだ
    pause
    exit /b 1
)

if not exist "%CMD%" (
    echo %CMD% が見つからないのだ
    pause
    exit /b 1
)

echo.
echo %EXE% と %CMD% を結合して
echo %OUT% を作成しますか？
echo.

choice /c YN /m "実行しますか"

if errorlevel 2 (
    echo キャンセルしたのだ
    pause
    exit /b
)

copy /b "%EXE%" + "%CMD%" "%OUT%" >nul

echo.
echo 完了！
echo %OUT% を作成したのだ
pause
