:: myXConv - myX変換 専用バッチ
:: Toolsの入れ替え＋更新
:: 確実にここをカレントにして実行
@echo off

:: /d ディレクトリ切り替え
:: "%~dp0" 実行ファイルパス取得
cd /d "%~dp0"

:: Userフォルダが無ければ終了
if not exist "User" (
    echo Userフォルダが存在しません。
    timeout /t 2 >nul
    exit /b
)

echo コンボBOXの切替え：[Tools]⇔[User]
echo.
echo ≫ Enter=切替え / 0=終了
set /p x="> "
if "%x%"=="" (
    cd %~dp0
    ren Tools _Tools >nul 2>&1 || ren _Tools Tools >nul 2>&1
)
if /i "%x%"=="0" (
    echo 終了します & pause
    exit /b
)

:: メッセージ表示
echo リネームしました

:: 本体ファイル
set APP_NAME=myxconv.exe

:: 自分自身を終了するために古いプロセスを終了
taskkill /f /im "%APP_NAME%"

:: メッセージの表示時間
timeout /t 2 >nul

:: 新しいインスタンスを起動
start "" "%APP_NAME%"

:: 終了メッセージ表示
echo 切り替え完了しました

:: メッセージの表示時間
timeout /t 2 >nul

:: バッチを終了
exit /b
