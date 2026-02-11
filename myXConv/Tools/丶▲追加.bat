:: 種類：バッチファイル
:: 概要：コピー＋更新（確認コピー →  再起動）
@echo off
setlocal

:: カレントのパス
set "DEST_DIR=%~dp0"

:: 親フォルダ
set "PARENT=%DEST_DIR%.."

:: コピー元
set "SRC=%~1"

:: コピー元存在確認
if not exist "%SRC%" (
    echo コピー元が存在しないのだ: %SRC%
    pause
    exit /b 1
)

echo コピー元: %SRC%
echo コピー先: %DEST_DIR%

:: 上書き確認
if exist "%SRC%" (
    echo 同名ファイルがあるのだ。上書きしますか？ (Y/N)
    set /p CHOICE=
    if /i not "%CHOICE%"=="Y" (
        echo コピーをキャンセルするのだ
        exit /b 0
    )
    set "MSG=ファイルを上書きしたのだ"
) else (
    set "MSG=ファイルをコピーしたのだ"
)

copy /Y "%SRC%" "%DEST_DIR%\" >nul
echo 追加先＞%DEST_DIR%
echo %MSG%！続行で更新なのだ
pause

:: EXE パス
set "EXE=%PARENT%\myXConv.exe"

:: 古いプロセスを終了
taskkill /f /im myXConv.exe >nul 2>&1

:: 再起動
cd /d "%~dp0.."
start "" "%EXE%"

exit /b
