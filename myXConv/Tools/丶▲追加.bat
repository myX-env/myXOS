:: 種類：バッチファイル
:: 概要：判定コピー＋更新（確認コピー →  再起動）
@echo off
setlocal

:: コピー元存在確認
if not exist "%~1" (
    echo コピー元が存在しないのだ: %~1
    pause
    exit /b 1
)

echo コピー元: %~1
echo コピー先: %~dp0

:: 続行確認
echo %~nx1 をコピー追加します。
echo [Enter]で続行 [0]で終了
set /p x="> "
if "%x%"=="0" echo 終了します & pause & exit /b

:: 上書き確認
if exist "%~dp0%~nx1" (
    echo 同名ファイルがあるのだ。上書きしますか？ [Y/N]
    set "OVR_CHOICE="
    set /p OVR_CHOICE="入力してEnter: "
    
    :: 入力が Y または y の場合のみコピーへ進む
    if /i "%OVR_CHOICE%"=="Y" (
        goto :DO_COPY
    ) else (
        echo キャンセルされたのだ。
        pause
        exit /b 0
    )
)

:DO_COPY
echo ファイルをコピー中なのだ...
copy /Y "%~1" "%~dp0" >nul

echo 追加完了＞%~dp0
echo 続行で再起動するのだ
pause

:: プロセス終了と再起動
taskkill /f /im myXConv.exe >nul 2>&1
cd /d "%~dp0.."
start "" "myXConv.exe"

exit /b
