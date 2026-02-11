::------------------------------- 
:: myXシリーズ16（XR） 
:: myXReturn - リターンBAT v1.0 -
:: 自己リネームトグル[User2]⇔[_User2]
:: 固定名/自由名
:: 【注意】実行すると「自分の名前」と
::       「親フォルダ名」が即座に反転する
:: 【警告】挙動が非常に直感に反するため
::        バッチ職人専用
::-------------------------------
@echo off

:: ★キーナビを起動（不要ならOFF）
pushd "%~dp0..\myXKey"
start "" /b "myXKey.exe"
popd

set m=%~nx0
echo ≫ 起動中の対象ファイル：[%~nx0]
echo.
echo [1] 自由名トグル：[XXX.bat]⇔[_XXX.bat]
echo [2] 固定名トグル：[User2.bat]⇔[_User2.bat]
echo.
echo Enter=スキップ / 1=自由名 / 2=固定名 / 0=終了
set /p x="> "
if "%x%"=="" goto :skip
if /i "%x%"=="0" (
    echo 終了します & pause
    REM キーナビも終了---★
    taskkill /im myXKey.exe /f >nul 2>&1
    exit
)
:: --- 自由名（頭バーの有無） ---
if "%x%"=="1" (
    if "%m:~0,1%"=="_" (
        ren "%m%" "%m:~1%"
    ) else (
        ren "%m%" "_%m%"
    )
    echo 切替え完了！
    set /p x="[Enter]で閉じます"
    REM キーナビも終了---★
    taskkill /im myXKey.exe /f >nul 2>&1
    exit
)

:: --- 固定名（User2ベース） ---
if "%x%"=="2" (
    ren User2.bat _User2.bat >nul 2>&1 || ren _User2.bat User2.bat
    echo 切替え完了！
    set /p x="[Enter]で閉じます"
    REM キーナビも終了---★
    taskkill /im myXKey.exe /f >nul 2>&1
    exit
)

:skip
echo スキップ完了＞本処理へ
echo.
echo ここから外部バッチの本処理へ
pause
@echo off
echo このバッチは _User2.bat が存在する場合に
echo User2.bat から優先実行されるテスト用確認バッチです。
echo _User2+.bat (+)など付けておけば実行されない
echo.
echo 現在の起動ファイル名：%~nx0
echo.
echo [Enter]でユーザー指定バッチを起動
echo [0]で終了
set /p x="> "
if "%x%"=="0" exit /b

cd /d "%~dp0..\myXBlank"
if exist "XB.bat" (
    call "XB.bat" || call "%~dp0..\myXAppBAT\myXFull.bat"
) else (
    call "%~dp0..\myXAppBAT\myXHelper.bat"
)
::exit /b
echo 処理完了！ここまで外部埋め込み
pause
REM キーナビも終了---★
taskkill /im myXKey.exe /f >nul 2>&1
exit
