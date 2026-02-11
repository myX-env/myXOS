::--------------------------------------
:: myXシリーズ11（XA）
:: myXAppBAT - BATランチャー（汎用柔軟型）
:: 外部フォルダ指定対応（自動リスト＋補足）
:: コマンド：menu.bat D:\myX\myXAppBAT
:: →そのフォルダ内をメニューとして表示
:: myX*.bat（myXが付いたバッチを対象）
:: 番号の前に"@"を付けると中身を参照できる
::--------------------------------------
@echo off
cls
:: ★キーナビを起動（不要ならOFF）
pushd "%~dp0..\myXKey"
start "" /b "myXKey.exe"
popd

setlocal enabledelayedexpansion

:: 指定なし→この場所に
set "TARGET=%~1"
if not defined TARGET set "TARGET=%~dp0"

:menu
echo BATランチャー（汎用型）
echo 参照先＞%TARGET%
echo.

set idx=0
:: 配列のように説明を設定（ファイル名をキーに）
for %%F in ("%TARGET%\myX*.bat") do (
    set /a idx+=1
    set "fname=%%~nxF"
    set "desc="
    if /i "%%~nF"=="myXAppBAT_win" set "desc=BATランチャーWinアプリ"
    if /i "%%~nF"=="myXBlank" set "desc=変換BOX_空箱"
    if /i "%%~nF"=="myXConv" set "desc=変換もどき"
    if /i "%%~nF"=="myXDiff" set "desc=比較転生"
    if /i "%%~nF"=="myXExeway" set "desc=中継EXE"
    if /i "%%~nF"=="myXFull" set "desc=フルBAT"
    if /i "%%~nF"=="myXHelper" set "desc=Xヘルパー"
    if /i "%%~nF"=="myXKey" set "desc=キーナビ"
    if /i "%%~nF"=="myXName" set "desc=命名マスター"
    if /i "%%~nF"=="myXPad" set "desc=XP風メモ帳"
    if /i "%%~nF"=="myXReturn" set "desc=リターンBAT"
    if /i "%%~nF"=="myXSend" set "desc=送る無双"
    if /i "%%~nF"=="myXTimemo9" set "desc=タイメモ9"
    if /i "%%~nF"=="myXView" set "desc=Xビュー"
    if /i "%%~nF"=="myXWorker" set "desc=Xワーカー"
    if /i "%%~nF"=="myXZipRun" set "desc=ZIPRUN"
    if /i "%%~nF"=="myX－仮登録サンプル" set "desc=コメント"

    echo !idx!. !fname! :: !desc!
)

:: ファイル総数を記録して最後にクリア項目を追加
set "MAX_NUM=!idx!"
set /a nextNum=!MAX_NUM!+1
echo !nextNum!. 画面クリア

echo 0. 終了
echo.

set /p raw=番号入力（@番号=プレビュー）： 
if not defined raw goto menu

set "prefix=%raw:~0,1%"
if "%prefix%"=="@" (
    set "num=%raw:~1%"
) else (
    set "num=%raw%"
)

:: 0なら終了
for /f "delims=0123456789" %%A in ("%num%") do goto menu
if %num% lss 1 (
    if "%num%"=="0" echo BATランチャーを終了します
    pause
        REM キーナビも終了---★
        taskkill /im myXKey.exe /f >nul 2>&1
    exit /b
    goto menu
)

:: ★ n番目の myX*.bat を処理
set /a idx=0
for %%F in ("%TARGET%\myX*.bat") do (
    set /a idx+=1
    if !idx! equ %num% (
        if "%prefix%"=="@" (
            echo --- プレビュー: %%~nxF の内容 ---
            type "%%F"
            echo --------------------------------
            pause
        ) else (
            call "%%F"
        )
        goto menu
    )
)

:: cls項目
if "%num%"=="!nextNum!" (
    cls
    goto menu
)

goto menu
