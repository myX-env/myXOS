::--------------------------------------
:: myXシリーズ11（XA）
:: myXAppBAT - BATランチャー（汎用柔軟型）
:: 外部フォルダ指定対応（自動リスト＋補足）
:: コマンド：本体.bat フォルダパス
:: →そのフォルダ内をメニューとして表示
:: 番号の前に"@"を付けると中身を参照できる
:: 対象ファイル：全て
:: .cmd と .bat は動作は同じ。
:: 基本型・テンプレ・保存用は .cmd で管理
::--------------------------------------
@echo off
setlocal enabledelayedexpansion

:: 引数があれば対象に、なければ自身の場所
set "TARGET=%~1"
if not defined TARGET set "TARGET=%~dp0"
if not exist "%TARGET%" (
    echo 指定フォルダが見つかりません：%TARGET%
    pause
    exit /b
)

:menu
echo BATランチャー（汎用型）
echo 参照先＞%TARGET%
echo.

set idx=0
:: 配列のように説明を設定（ファイル名をキーに）
for %%F in ("%TARGET%\*.*") do (
    set /a idx+=1
    set "fname=%%~nxF"
    set "desc="
    if /i "%%~nF"=="myXPad" set "desc=XP風メモ帳"
    if /i "%%~nF"=="myXAppBAT_win" set "desc=Winアプリランチャー"
    if /i "%%~nF"=="myX－仮登録サンプル" set "desc=コメント"

    echo !idx!. !fname! :: !desc!
)

:: ファイル総数を記録して最後にクリア項目を追加
set "MAX_NUM=!idx!"
set /a nextNum=!MAX_NUM!+1
echo !nextNum!. 画面クリア

echo 0. 終了
echo.

set /p raw=番号入力（@数字=プレビュー）： 
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
    exit
    goto menu
)

:: n番目の myX*.bat を処理
set /a idx=0
for %%F in ("%TARGET%\*.*") do (
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
