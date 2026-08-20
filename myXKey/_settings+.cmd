:: 設定切替
:: - 優先切替え：settings+.cmd / _settings+.cmd
:: - 有効・無効：settings+.cmd / settings+.bat
:: "_"バーの有無：settings.cmd の前後（環境依存）
:: ".bat"：設定無効
@echo off

echo.
echo File: [%~nx0]
echo.
echo Toggle: [settings+.cmd] / [_settings+.cmd]
echo Toggle: [settings+.cmd] / [settings+.bat]
echo.
echo ^>^> Enter="_" ON ^<-^> OFF / 1=cmd ^<-^> bat / 0=END
echo        RANK UP-DOWN     /  SET ON-OFF   / EXIT
set /p x="> "

rem 入力チェック（先に「処理なし」だけ弾く）
if /i "%~nx0"=="settings+.bat" (
    if /i "%x%"=="" (
        echo No processing
        pause
        exit /b 1
    )
)

if /i "%~nx0"=="_settings+.cmd" (
    if /i "%x%"=="1" (
        echo No processing
        pause
        exit /b 1
    )
)

rem 以降、通常のリネーム処理
if "%x%"=="" (
    echo Renaming...
    timeout /t 2 >nul
    cd /d %~dp0
    ren settings+.cmd _settings+.cmd >nul 2>&1 || ren _settings+.cmd settings+.cmd >nul 2>&1
    exit /b
)

if /i "%x%"=="1" (
    echo Renaming...
    timeout /t 2 >nul
    cd /d %~dp0
    ren settings+.cmd settings+.bat >nul 2>&1 || ren settings+.bat settings+.cmd >nul 2>&1
    exit /b
)

if /i "%x%"=="0" (
    echo END
    pause
    exit /b
)

rem その他入力はエラーにする
echo Input Error
pause
exit /b 1

::-- ここから設定・解説 --
settings+.cmd：UTF-8形式
実行すると settings+.cmd ⇔ _settings+.cmd を切り替える

詳細な記述方法は settings.cmd を参照
※Button3は（XL）インライン電卓用

現在適用される設定（ButtonX=行のみ有効）
@HELP_START@
Button1=全#|^a|#
Button2=戻<|^z|^y
Button3=計歴|^b|#v
Button4=検＊|^f|#x
@HELP_END@
