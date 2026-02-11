:: ZIPRUN呼び出しでXCフォルダのZIPが参照される
@echo off
:: ★キーナビを起動（不要ならOFF）
pushd "%~dp0..\..\myXKey"
call XK.bat
popd

rem 現場移動 → 本体起動 → 元戻り
pushd "%~dp0..\XC"
echo ZIPRUN の起動
echo.
echo ≫ Enter=起動 / 1=切替えて起動 / 2=切替えのみ / 0=終了
set /p x="> "
if "%x%"=="1" (
    call "[XC]⇔[_XC].bat"
    echo 起動します
    timeout /t 1 >nul
    call "%~dp0..\..\myXZipRun/XZ_exe.bat" %*
    goto end
)
if "%x%"=="2" (
    call "[XC]⇔[_XC].bat"
    goto end
)
if "%x%"=="0" (
    echo 終了します & pause
    goto end
)
if "%x%"=="" (
call "%~dp0..\..\myXZipRun/XZ_exe.bat" %*
)
popd

:end
REM キーナビを終了---★
taskkill /im myXKey.exe /f >nul 2>&1
exit /b
