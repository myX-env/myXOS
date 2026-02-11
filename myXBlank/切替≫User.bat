:: Tools ⇔ _Tools リネームで順位を下げる
:: トグルバッチ：自身のファイル名も同時に変更される
:: アプリ裏メニューのローカル選択からの起動用
@echo off

:: BATトグル
set TL=切替≫Tools.bat
set US=切替≫User.bat

:: 本体ファイル
set APP_NAME=myXBlank.exe
echo.
echo コンボBOXの切替え：[Tools]⇔[User]
echo.
echo ≫ 現在ファイル名：[%~nx0]
echo.
echo ≫ Enter=切替え / 0=終了
set /p x="> "
if "%x%"=="" (
    cd %~dp0
    ren "%US%" "%TL%" >nul 2>&1 || ren "%TL%" "%US%"
    ren Tools _Tools >nul 2>&1 || ren _Tools Tools

    :: 自身を終了するために古いプロセスを終了
    taskkill /f /im "%APP_NAME%" >nul 2>&1

    :: 終了メッセージを2秒表示
    echo リネーム完了！
    echo 変換BOX_空箱を再起動します
    timeout /t 2 >nul

    :: 新しいインスタンスを起動
    start "" "%APP_NAME%"

    :: バッチCMDを終了
    exit
)
if /i "%x%"=="0" (
    echo 終了します & pause
    exit
)

