::------------------------------- 
:: myXシリーズ16（XR）
:: myXReturn - リターンBAT v1.0 -
:: 自己リネームトグル[User]⇔[_User]
:: 現行仕様：バー切替え / 名前切替え
:: 処理は異なるが初期では同じ結果（_トグル）
:: 【注意】実行すると「自分の名前」が
::        即座に反転する
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
echo [1] バー切替え ：[XXX.bat]⇔[_XXX.bat]
echo [2] 名前切替え ：[XXX.bat]⇔[ABC.bat]
echo.
echo Enter=スキップ / 1=バー切替 / 2=名前切替 / 0=終了
set /p x="> "
if "%x%"=="" goto :skip
if /i "%x%"=="0" (
    echo 終了します & pause
    REM キーナビも終了---★
    taskkill /im myXKey.exe /f >nul 2>&1
    exit
)
:: --- バー切替え（先頭 _ の付与/削除） ---
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

:: --- 名前切替え（登録名ペア切替） ---
if "%x%"=="2" (
    ren User.bat _User.bat >nul 2>&1 || ren _User.bat User.bat
    echo 切替え完了！
    set /p x="[Enter]で閉じます"
    REM キーナビも終了---★
    taskkill /im myXKey.exe /f >nul 2>&1
    exit
)

:skip
echo スキップ完了＞本処理へ
echo.
echo 本処理へ...
echo ※ここに実行コマンドを置くと
echo ※XRトグル後の処理を続行
echo ※現在は処理なし
pause
REM キーナビも終了---★
taskkill /im myXKey.exe /f >nul 2>&1
exit
