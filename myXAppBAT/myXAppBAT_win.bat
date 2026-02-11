:: myXシリーズ11（XA）
:: myXAppBAT - BATランチャーWin-app版
:: コンソール対話型、引数起動対応(リスト番号)
:: 初回メニュー作成後ループ、後始末終了
:: skip対策で1,2を設定とdirで固定の完成版
::--------------------------------------
@echo off
cls
setlocal enabledelayedexpansion

:: 初回のみ win_list.txt を作成
(
echo 設定コマンド      ≫設定（固定）Win10以降
echo dirコマンド       ≫ファイルリスト（固定）
echo control.exe       ≫コントロールパネル
echo regedit.exe       ≫レジストリエディタ
echo cleanmgr.exe      ≫ディスククリーンアップ
echo cmd.exe           ≫コマンドプロンプト
echo powershell.exe    ≫PowerShell
echo taskmgr.exe       ≫タスクマネジャー
echo sndvol.exe        ≫音声ボリューム
echo notepad.exe      ≫メモ帳
echo write.exe        ≫ワードパッド
echo mspaint.exe      ≫ペイント
echo calc.exe         ≫電卓
echo charmap.exe      ≫文字コード表
echo osk.exe          ≫スクリーンキーボード
echo magnify.exe      ≫拡大鏡
echo snippingtool.exe ≫スニッピングツール
echo main.cpl         ≫マウスのプロパティ
echo desk.cpl         ≫画面のプロパティ
echo appwiz.cpl       ≫プログラムの追加と削除
echo intl.cpl         ≫地域と言語
echo mmsys.cpl        ≫サウンド
echo ncpa.cpl         ≫ネットワーク
echo sysdm.cpl        ≫システム
echo timedate.cpl     ≫日付と時刻
echo hdwwiz.cpl       ≫ハードウェアの追加
echo firewall.cpl     ≫ファイアウォール
echo powercfg.cpl     ≫電源
echo SystemPropertiesProtection.exe ≫システムの保護（復元設定）
echo SystemPropertiesAdvanced       ≫システムの詳細設定
echo SystemPropertiesHardware.exe   ≫デバイスマネージャ関連
echo explorer shell:::{2559a1f3-21d7-11d4-bdaf-00c04f60b9f0} ≫ﾌｧｲﾙ入ｶ
echo explorer shell:::{645FF040-5081-101B-9F08-00AA002F954E} ≫ごみ箱
echo explorer.exe       ≫エクスプローラー
echo cls :: 画面クリア
echo exit :: 終了（ 0：ゼロか該当しない番号）※前回番号［Enter］／Ｆ７
) > win_list.txt

:: 引数があればその番号を使用し、1回実行して終了
if not "%~1"=="" (
    set "num=%~1"
    goto run_once
)

:: 対話ループモード("::"補足を有効化)
:loop
echo BATランチャー（Windows版）
echo 起動元＞%~f0
echo.
set n=0
for /f "tokens=1* delims=::" %%a in (win_list.txt) do (
    set /a n+=1
    set "cmd=%%a"
    set "desc=%%b"
    echo !n!. !cmd! - !desc!
)
:: ここで最終番号のMAX_NUMに保存する
set /a MAX_NUM=%n%
echo.
set /p num=番号を入力してください：

:run_once
set /a skip=%num% - 1

:: 1 = 設定（固定・安全）
if %num%==1 (
REM 設定コマンド--★
    start ms-settings:
    pause
    if "%~1"=="" goto loop
    goto end
)

:: 2 = dir（内部コマンド直実行）
if %num%==2 (
    dir
    pause
    if "%~1"=="" goto loop
    goto end
)

:: 0 か最大行なら終了
if %num%==0 goto end
if %num%==%MAX_NUM% goto end
for /f "usebackq skip=%skip% tokens=* delims=" %%L in ("win_list.txt") do (
    set "line=%%L"
    if "!line!"=="" goto loop
    for /f "tokens=1,*" %%a in ("!line!") do (
        set "cmd=%%a"
        if /i "%%a"=="explorer" (
            set "cmd=%%a %%b"
        ) else if /i "%%a"=="del" (
            set "cmd=%%a %%b"
        )
        call !cmd!
        if "%~1"=="" goto loop
        goto end
    )
    set /a n+=1
)
:end
del win_list.txt
echo del win_list.txt：メニューをクリア
echo exit：BATランチャー（Windows版）を終了
echo 起動元へ戻ります
pause
exit /b
