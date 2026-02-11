:: 種類：バッチファイル
:: 概要：削除＋更新（確認ゴミ箱 → myX変換 再起動）
@echo off
setlocal enabledelayedexpansion
:: 引数ごとに処理
for %%F in (%*) do (
    echo 処理対象: %%~fF
    
    :: ユーザーに確認を求める
    set /p choice="%%~nxF をゴミ箱に移動しますか？ (y/n): "
    
    :: 選択内容の表示（デバッグ用）
    echo 選択内容: !choice!
    
    if /i "!choice!"=="y" (
        if exist "%%~fF\" (
            echo フォルダ %%~nxF を検出
            powershell -Command "Add-Type -AssemblyName Microsoft.VisualBasic; [Microsoft.VisualBasic.FileIO.FileSystem]::DeleteDirectory('%%~fF', 'OnlyErrorDialogs', 'SendToRecycleBin')" || echo PowerShellエラー: %%~nxF
            echo フォルダ %%~nxF をゴミ箱に移動しました。
        ) else (
            if exist "%%~fF" (
                echo ファイル %%~nxF を検出
                powershell -Command "Add-Type -AssemblyName Microsoft.VisualBasic; [Microsoft.VisualBasic.FileIO.FileSystem]::DeleteFile('%%~fF', 'OnlyErrorDialogs', 'SendToRecycleBin')" || echo PowerShellエラー: %%~nxF
                echo ファイル %%~nxF をゴミ箱に移動しました。
            ) else (
                echo %%~fF は存在しません。スキップします。
            )
        )
    ) else if /i "!choice!"=="n" (
        echo %%~nxF をスキップしました。
    ) else (
        echo 無効な入力です。スキップします。
    )
)
echo ゴミ箱に移動しました！更新します。

pause

:: EXE パス
set "EXE=%~dp0..\..\myXConv.exe"

:: 古いプロセスを終了
taskkill /f /im myXConv.exe >nul 2>&1

:: 再起動
cd /d "%~dp0.."
start "" "%EXE%"

exit /b

