:: Auto Config Switch (CMD)
:: Change [settings+.cmd] / [_settings+.cmd]
:: Control Settings
@echo off

echo.
echo File: [%~nx0]
echo.
echo Toggle: [settings+.cmd] / [_settings+.cmd]
echo.
echo ^>^> Enter=OK / 0=END
set /p x="> "
if "%x%"=="" (

:: message
echo Renaming...

:: timeout 2000ms
timeout /t 2 >nul

    cd %~dp0
    ren settings+.cmd _settings+.cmd >nul 2>&1 || ren _settings+.cmd settings+.cmd >nul 2>&1
)

if /i "%x%"=="0" (
    echo END & pause
    exit /b
)

exit /b

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
