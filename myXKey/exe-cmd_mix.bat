:: myXKey.exe と settings.cmd を1本化するバッチ
:: 設定を直接埋め込み自分専用の実行ファイルを作成する
:: myXKey.exe の末尾に settings.cmd の内容をバイナリ結合する
:: 結合後は、設定内容を含んだ別名の実行ファイルとして保存する
:: 元の myXKey.exe と settings.cmd はそのまま残す
@echo off
setlocal

set "EXE=myXKey.exe"
set "CMD=settings.cmd"
set "OUT=myXKey_設定込.exe"
::set "OUT=myXKey_汎用.exe"
::set "OUT=myXKey_専用.exe"

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
