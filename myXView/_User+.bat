:: 自己リネームトグル[_User]⇔[_User+]
:: _User.bat にすると、このバッチが割り込める
:: さらに動作も指定できる
@echo off

:: ★キーナビを起動（不要ならOFF）
pushd "%~dp0..\myXKey"
start "" /b "myXKey.exe"
popd

set m=%~nx0
echo ≫ 起動中の対象ファイル：[%~nx0]
echo.

echo [1] 末尾(+)トグル：[_User.bat]⇔[_User+.bat]
echo.
echo Enter=指定アプリ起動 / 1=リネーム / 0=終了
set /p x="> "
if "%x%"=="" goto :skip
if /i "%x%"=="0" (
    echo 終了します & pause
    REM キーナビも終了---★
    taskkill /im myXKey.exe /f >nul 2>&1
    exit
)

:: --- 固定名（プラス記号"+"追加） ---
if "%x%"=="1" (
    ren _User.bat _User+.bat >nul 2>&1 || ren _User+.bat _User.bat
    echo 切替え完了！
    set /p x="[Enter]で閉じます"
    REM キーナビも終了---★
    taskkill /im myXKey.exe /f >nul 2>&1
    exit
)

:skip
:: ★ここでアプリを指定して、更に保険として1つ指定可能
echo Xヘルパーを起動します。
echo ※起動に失敗した場合は、フルBATに切り替わります。
pause
pushd "%~dp0..\myXAppBAT"
call "myXHelper.bat" || call "myXFull.bat"
popd

REM キーナビも終了---★
taskkill /im myXKey.exe /f >nul 2>&1
exit
