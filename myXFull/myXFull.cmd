::------------------------------
:: myXシリーズ13（XF）
:: myXFull - フルBAT -  v1.0
:: フル装備型の二刀流バッチ
:: 送る／単体でも引数起動、PS対応
:: 外部EXE補助：myXKey（キーナビ）
:: 外部EXE補助：Clip_F2P（パス変換）
:: 内部PS補助：引数を保持して起動
:: ★最初に引数手動、シンプル軽量版
:: ※ 基本型のバッチはCMDで保存用
::------------------------------
@echo off
cls
setlocal enabledelayedexpansion

:: ★--SendToフォルダ：手動指定--★
:: set 指定がなければ、この場所が参照先になる
::set "sendTo=%~dp0..\myXSend\SendTo_bak"
::set "sendTo=%APPDATA%\Microsoft\Windows\SendTo"
::set "sendTo=%~dp0..\myXAppBAT"
if not exist "%sendTo%" (
    set "sendTo=%~dp0"
)

:: キーナビ起動
pushd "%~dp0..\myXKey"
call XK.bat
popd

:: 引数取得（1ファイル前提）
:: Clip_F2P.exe → ファイルクリップをテキストパスに変換
if "%~1"=="" (
    for /f "usebackq delims=" %%C in (`%~dp0..\myXKey\Ext\Clip_F2P.exe`) do (
        set "pseudoArgs=%%C"
    )

    if "!pseudoArgs!"=="" (
        echo （対象ファイル貼付け：パス文字列／ファイルクリップ どちらもOK）
        set /p "pseudoArgs=ファイルが無ければ Enter でスキップ: "
    )
) else (
    set "pseudoArgs=%~1"
)

echo 参照先＞%sendTo%
echo.
set i=0
for %%F in ("%sendTo%\*.bat" "%sendTo%\*.ps1" "%sendTo%\*.exe" "%sendTo%\*.lnk") do (
    set /a i+=1
    set "file!i!=%%F"
    echo !i!: %%~nxF
)

:select
:: ファイル総数を記録して最後にクリア項目を追加
set "MAX_NUM=!i!"
set /a nextNum=!MAX_NUM!+1
echo !nextNum!. 画面クリア
echo 0: 終了
echo.
set /p "line=番号を入力: "

if "%line%"=="0" (
    echo 終了します
    pause
    goto end
)

set "sel=%line%"
if not defined file%sel% goto select

set "selected=!file%sel%!"

for %%X in ("%selected%") do set "ext=%%~xX"

:: 実行前にキーナビ終了
taskkill /f /im myXKey.exe >nul 2>&1

:: 実行
if /i "%ext%"==".bat" (
    call "%selected%" "%pseudoArgs%"
) else if /i "%ext%"==".ps1" (
    powershell -ExecutionPolicy Bypass -File "%selected%" "%pseudoArgs%"
) else (
    start /wait "" "%selected%" "%pseudoArgs%"
)

:end
:: キーナビ終了
taskkill /f /im myXKey.exe >nul 2>&1
endlocal
exit /b
