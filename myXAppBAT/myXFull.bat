:: 指定アプリを固定パスから呼び出すバッチ
@echo off

:: キーナビ終了(重複防止のため)
taskkill /f /im myXKey.exe >nul 2>&1

rem 現場移動 → 本体起動 → 元戻り
cd /d "%~dp0..\myXFull"
call myXFull.bat
exit /b

---★ここからアプリ情報

::------------------------------
:: myXシリーズ13（XF）
:: myXFull - フルBAT -  v1.0
:: 送る無双とBATランチャーの二刀流
:: 単体起動でも引数起動、PS対応
:: 内部PS補助：ファイルclipをパスコピー
:: 外部EXE補助：★キーナビ
:: ★最初に引数手動、シンプル軽量版
:: ≫参照先："sendTo=D:\myX\myXAppBAT"
:: ≫終了時：exit (/b) で CMD 閉じる
::------------------------------
@echo off
cls
setlocal enabledelayedexpansion

:: ★--SendToフォルダ：手動指定--★（現在：BATランチャー）
::[myXFull] set 指定がなければ、この場所が参照先になる
::[送る無双]set "sendTo=D:\myX\myXSend\SendTo_bak"
::[Win送る]set "sendTo=%APPDATA%\Microsoft\Windows\SendTo"
set "sendTo=D:\myX\myXAppBAT"
if not exist "%sendTo%" (
    set "sendTo=%~dp0"
)

:: キーナビ起動（絶対パス）
::start "" /b "%~dp0..\myXKey\myXKey.exe"
start "" /b "D:\myX\myXKey\myXKey.exe"

:: 引数取得（右クリック1ファイル前提）
::カッコ内が相対パスの場合→(`%~dp0..\myXKey\Ext\Clip_F2P.exe`)
if "%~1"=="" (
    for /f "usebackq delims=" %%C in (`D:\myX\myXKey\Ext\Clip_F2P.exe`) do (
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

---★ここからアプリ情報
