::---------------------------------------
:: myXシリーズ11（XA）
:: myXAppBAT - BATランチャー（固定リスト型）
:: BATファイル丸投げ統一（シンプル＆効率化）
:: @プレビュー実装、手動編集・補足
::---------------------------------------
@echo off
cls
:: ★キーナビを起動（不要ならOFF）
pushd "%~dp0..\myXKey"
start "" /b "myXKey.exe"
popd

setlocal enabledelayedexpansion

:: 初回のみ menu_list.txt を作成
(
echo myXPad.bat         :: #01 XP風メモ帳    － ﾒﾓ帳/簡易編集 － myXPad（XP）
echo myXConv.bat        :: #02 変換もどき    － ﾌｧｲﾙ受け渡し － myXConv（XC）
echo myXHelper.bat      :: #03 Xヘルパー     － 汎用ﾎﾞﾀﾝﾗﾝﾁｬｰ－ myXHelper（XH）
echo myXSend.bat        :: #04 送る無双      － 第2の「送る」 － myXSend（XS）
echo myXDiff.bat        :: #05 比較転生      － 2窓ﾃｷｽﾄ比較  － myXDiff（XD）
echo myXZipRun.bat      :: #06 ZIPRUN        － ZIP/PSﾗﾝﾁｬｰ － myXZipRun（XZ）
echo myXName.bat        :: #07 命名マスター  － 命名補助     － myXName（XN）
echo myXWorker.bat      :: #08 Xワーカー     － 擬似GUIﾗﾝﾁｬｰ － myXWorker（XW）
echo myXTimemo9.bat     :: #09 タイメモ9     － 収集Clip活用 － myXTimemo9（XT）
echo myXBlank.bat      :: #10 変換BOX_空箱  － 外部ﾃｷｽﾄ変換 － myXBlank（XB）
echo myXAppBAT_win.bat :: #11 BATランチャー － 汎用BATﾗﾝﾁｬｰ － myXAppBAT（XA）
echo myXKey.bat        :: #12 キーナビ      － ﾃﾝｷｰ入力補助 － myXKey（XK）
echo myXFull.bat       :: #13 フルBAT       － 組込BATﾗﾝﾁｬｰ － myXFull（XF）
echo myXExeway.bat     :: #14 中継EXE       － EXE仲介ﾗｯﾊﾟｰ － myXExeway（XE）
echo myXView.bat       :: #15 Xビュー       － EXE内ﾍﾙﾌﾟ確認 － myXView（XV）
echo myXReturn.bat     :: #16 リターンBAT   － 自己ﾘﾈｰﾑﾄｸﾞﾙ － myXReturn（XR）
) > menu_list.txt

:loop
echo BATランチャー（固定リスト型）
echo 参照先＞%~dp0
::%~f0
echo.
set n=0
for /f "tokens=1* delims=::" %%a in (menu_list.txt) do (
    set /a n+=1
    echo !n!. %%a - %%b
)
set /a n+=1
echo !n!. cls - 画面クリア
set "clsNum=!n!"
echo 0. 終了 ※前回番号［Enter］／Ｆ７
echo.
set /p raw=番号を入力（@番号で詳細、0 ゼロで終了）：

set "num=!raw:*@=!"
set "prefix=!raw:~0,1!"

:: 0 ゼロで終了
if "!num!"=="0" goto end
:: 最終番号でクリア
if "%num%"=="!clsNum!" cls & goto loop

:: 【重要】スキップ数を計算（入力番号-1）
set /a skip=!num!-1

:: 一時ファイルから目的の行だけ取得
for /f "tokens=1* delims=::" %%a in ('more +!skip! menu_list.txt') do (
    set "cmd=%%a"
    if "!prefix!"=="@" (
        type "!cmd!"
        pause
    ) else (
        if /i "!cmd!"=="do_cls.bat" (
            cls
        ) else (
            call "!cmd!"
        )
    )
    goto loop
)

:: 該当なし番号はメニューへ
goto loop

:end
del menu_list.txt
echo del menu_list.txt：メニューをクリア
echo exit：BATランチャーを終了します
pause
REM キーナビも終了---★
taskkill /im myXKey.exe /f >nul 2>&1
exit
