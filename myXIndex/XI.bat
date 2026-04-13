:: myXフォルダ＋カスタム
:: ステップ起動バッチ
@echo off

:loop
cls
echo ==== myXIndex メニュー ====
echo 1: myXフォルダリスト作成（初回）
echo 2: ツリービュア表示（リスト作成済）
echo 3: カスタム（Xワーカー経由で起動する）
echo 0: 終了
set /p sel=選択:

if "%sel%"=="1" (
    pushd "%~dp0..\myXIndex"
    start "" /wait myXIndex.exe "%~dp0..￥..\myX"
    popd
    goto loop
)

if "%sel%"=="2" (
    if exist "%~dp0..\..\myX_list.html" (
        start "" "%~dp0..\..\myX_list.html"
    ) else (
        echo インデックスが存在しません
        pause
    )
    goto loop
)

if "%sel%"=="3" (
    pushd "%~dp0..\myXWorker"
    start "" /wait powershell -ExecutionPolicy Bypass -File myXWorker.ps1 "%~dp0..\myXIndex\myXIndex.exe"
    popd
    goto loop
)

if "%sel%"=="0" exit

goto loop

