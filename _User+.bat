:: このファイル名：_User.bat(_User+.bat)
:: User.bat からの起動でこのバッチが起動
:: _User.bat で対話式の割り込みモード(_User+.batで無効化)
@echo off

:: ★キーナビを起動（不要ならOFF）
pushd "%~dp0myXKey"
call XK.bat
popd

echo ≫ User.bat から引き継いで起動中・・・
echo.
echo   しかし、_User.bat が割り込んできました！
echo   割込みを許可しますか？
echo.
echo ≫ 起動中の対象ファイル：[%~nx0]
echo.
echo   トグル切替：[_User.bat]⇔[_User+.bat]
echo.
echo ≫ Enter=許可 / 1=拒否→通常 / 2=トグル切替 / 0=中止
set /p x="> "
:: Enter=許可
if "%x%"=="" goto main
:: 1=拒否→通常
if "%x%"=="1" (
    echo 通常メニュー起動
    timeout /t 1 >nul
    REM 一旦このキーナビを終了---★
    taskkill /im myXKey.exe /f >nul 2>&1
    cd /d "%~dp0myXAppBAT"
    call menu.bat & exit /b
)
:: 2=切替え
if "%x%"=="2" (
    if %~nx0 == _User.bat ( ren _User.bat _User+.bat )
    if %~nx0 == _User+.bat ( ren _User+.bat _User.bat )
    echo 切替え完了！
    set /p dummy="Enter で閉じます"
    REM キーナビも終了---★
    taskkill /im myXKey.exe /f >nul 2>&1
)
:: 0=中止
if /i "%x%"=="0" (
    echo 割込みは中止されました。どれも実行されません。
    pause
    REM キーナビも終了---★
    taskkill /im myXKey.exe /f >nul 2>&1
    exit /b
)

:main
echo 割込み許可が下りました！
echo 変換BOX_空箱 が起動します
timeout /t 2 >nul
cd /d "%~dp0myXAppBAT"
if exist "myXBlank.bat" (
    call "myXBlank.bat" || call "myXFull.bat"
) else (
    echo 変換BOX_空箱 の起動に失敗したため、
    echo 代わりに フルBAT が起動されます
    pause
    call "myXFull.bat"
)
exit /b
