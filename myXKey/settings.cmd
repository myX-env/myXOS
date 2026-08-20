:: 設定切替（有効・無効）
:: settings.cmd / settings.bat
:: .cmd = 設定有効
:: .bat = 設定無効
@echo off

echo.
echo File: [%~nx0]
echo.
echo Toggle: [settings.cmd] / [settings.bat]
echo.
echo ^>^> Enter=OK / 0=END
set /p x="> "
if "%x%"=="" (

:: メッセージ表示
echo Renaming...

:: 2秒待機
timeout /t 2 >nul

    cd %~dp0
    ren settings.cmd settings.bat >nul 2>&1 || ren settings.bat settings.cmd >nul 2>&1
)

if /i "%x%"=="0" (
    echo END & pause
    exit /b
)

exit /b

::-- ここから設定・解説 --
settings.cmd：UTF-8形式
バッチ処理部では全角文字を使用しないこと

現在適用される設定（ButtonX=行のみ有効）
@HELP_START@
Button1=全#|^a|#v
Button2=戻<|^z|^y
Button3=
Button4=検*|^f|#x
@HELP_END@

記述形式（X＝ボタン番号）
ButtonX=表示名|左クリック|右クリック
空欄なら初期値

各項目の意味
表示名 ： ボタンに表示する文字
|      ： 区切り文字（半角の縦棒）
^      ： Ctrlキー
#      ： Windowsキー

例
^f  = Ctrl + F
#x  = Windows + X

※ Ctrlキーは小文字で記述する
　例：^f、^c、^v
